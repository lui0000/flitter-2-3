/// Domain Entity: Системный пользователь IDM
/// Чистая бизнес-модель без внешних зависимостей
class SystemUserEntity {
  final String id;
  final String name;
  final String email;
  final String department;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const SystemUserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  SystemUserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? role,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return SystemUserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemUserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

