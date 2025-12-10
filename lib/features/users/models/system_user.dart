/// Модель пользователя в системе IDM
class SystemUser {
  final String id;
  final String name;
  final String email;
  final String department;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const SystemUser({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  SystemUser copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? role,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return SystemUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

