import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/app_user.dart';

class AuthState {
  final bool isLoading;
  final String? token;
  final AppUser? user;
  final String? error;

  const AuthState({this.isLoading = false, this.token, this.user, this.error});

  bool get isAuthenticated => token != null && user != null;

  AuthState copyWith({
    bool? isLoading,
    String? token,
    AppUser? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      user: user ?? this.user,
      error: error,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AuthState());

  Future<void> login({required String phone, required UserRole role}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final dio = ref.read(dioProvider);

      final response = await dio.post(
        '/auth/login',
        data: {
          'phone': phone,
          'role': role == UserRole.teacher ? 'teacher' : 'student',
        },
      );

      final token = response.data['token'] as String;
      final user = AppUser.fromJson(response.data['user']);

      ref.read(authTokenProvider.notifier).state = token;

      state = state.copyWith(isLoading: false, token: token, user: user);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data.toString() ?? e.message,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void logout() {
    ref.read(authTokenProvider.notifier).state = null;
    state = const AuthState();
  }
}
