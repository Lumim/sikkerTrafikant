import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  static const items = [
    ('Lessons', Icons.present_to_all, '/teacher/home'),
    ('Close Tracks', Icons.traffic, '/teacher/home'),
    ('First Aid', Icons.medical_services_outlined, '/teacher/home'),
    ('Cases', Icons.directions_car_outlined, '/teacher/home'),
    ('Documents', Icons.description_outlined, '/teacher/home'),
    ('Contacts', Icons.perm_contact_calendar_outlined, '/teacher/home'),
    ('Exam', Icons.fact_check_outlined, '/teacher/home'),
    ('Calendar', Icons.calendar_month_outlined, '/calendar'),
    ('Notes', Icons.edit_note_outlined, '/teacher/home'),
    ('Sign queue', Icons.assignment_turned_in_outlined, '/teacher/home'),
    ('Chat', Icons.chat_bubble_outline, '/chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Home')),
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
