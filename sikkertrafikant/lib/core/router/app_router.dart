import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/shared/calendar/presentation/calendar_screen.dart';
import '../../features/shared/chat/presentation/chat_list_screen.dart';
import '../../features/student/home/presentation/student_home_screen.dart';
import '../../features/teacher/home/presentation/teacher_home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: '/teacher/home',
        builder: (_, __) => const TeacherHomeScreen(),
      ),
      GoRoute(
        path: '/student/home',
        builder: (_, __) => const StudentHomeScreen(),
      ),
      GoRoute(path: '/calendar', builder: (_, __) => const CalendarScreen()),
      GoRoute(path: '/chat', builder: (_, __) => const ChatListScreen()),
    ],
  );
});
