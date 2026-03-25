import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(authTokenProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/api',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ),
  );

  return dio;
});
