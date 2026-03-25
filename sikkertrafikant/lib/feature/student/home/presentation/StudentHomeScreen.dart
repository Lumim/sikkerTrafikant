import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  static const items = [
    ('My Lessons', Icons.school_outlined, '/student/home'),
    ('My Exams', Icons.fact_check_outlined, '/student/home'),
    ('Calendar', Icons.calendar_month_outlined, '/calendar'),
    ('Documents', Icons.description_outlined, '/student/home'),
    ('Notes', Icons.edit_note_outlined, '/student/home'),
    ('Chat', Icons.chat_bubble_outline, '/chat'),
    ('My Teacher', Icons.person_outline, '/student/home'),
    ('Progress', Icons.show_chart, '/student/home'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Home')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => context.go(item.$3),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.$2, size: 30),
                    const SizedBox(height: 12),
                    Text(item.$1, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
