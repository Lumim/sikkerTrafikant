import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/app_user.dart';
import 'auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  UserRole selectedRole = UserRole.teacher;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.user != null) {
        if (next.user!.role == UserRole.teacher) {
          context.go('/teacher/home');
        } else {
          context.go('/student/home');
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Sign in to continue'),
              const SizedBox(height: 24),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<UserRole>(
                value: selectedRole,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Role',
                ),
                items: const [
                  DropdownMenuItem(
                    value: UserRole.teacher,
                    child: Text('Teacher'),
                  ),
                  DropdownMenuItem(
                    value: UserRole.student,
                    child: Text('Student'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedRole = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          ref
                              .read(authProvider.notifier)
                              .login(
                                phone: phoneController.text.trim(),
                                role: selectedRole,
                              );
                        },
                  child: state.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Sign in'),
                ),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 12),
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
