import '../models/user_model.dart';

/// Удаленный источник данных для аутентификации
/// В реальном приложении здесь была бы работа с API
abstract class AuthRemoteDataSource {
  /// Вход в систему через API
  Future<UserModel> login(String email, String password);

  /// Регистрация через API
  Future<UserModel> register(String email, String password, String name);

  /// Выход из системы
  Future<void> logout();
}

/// Реализация с имитацией сервера
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Имитация сетевого запроса
    await Future.delayed(const Duration(seconds: 1));

    // Простая валидация (имитация проверки на сервере)
    if (email.isNotEmpty && password.length >= 4) {
      return UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: email.split('@').first,
        role: email.contains('admin') ? 'admin' : 'user',
      );
    }

    throw Exception('Неверные учетные данные');
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    // Имитация сетевого запроса
    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.length >= 4 && name.isNotEmpty) {
      return UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        role: 'user',
      );
    }

    throw Exception('Ошибка регистрации');
  }

  @override
  Future<void> logout() async {
    // Имитация сетевого запроса
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

