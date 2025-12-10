/// Domain Entity: Пользователь системы
/// Это чистая бизнес-модель без зависимостей от фреймворков
class UserEntity {
  final String id;
  final String email;
  final String name;
  final String role;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

