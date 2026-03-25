enum UserRole { teacher, student }

class AppUser {
  final String id;
  final String name;
  final String phone;
  final UserRole role;

  const AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      role: json['role'] == 'teacher' ? UserRole.teacher : UserRole.student,
    );
  }
}
