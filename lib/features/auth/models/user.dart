/// Модель пользователя системы
class User {
  final String id;
  final String email;
  final String name;
  final String role; // admin, manager, user

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });
}




