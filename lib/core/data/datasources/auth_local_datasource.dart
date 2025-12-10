import '../models/user_model.dart';

/// Локальный источник данных для аутентификации
/// В реальном приложении здесь была бы работа с SharedPreferences, SecureStorage и т.д.
abstract class AuthLocalDataSource {
  /// Получить текущего пользователя из локального хранилища
  Future<UserModel?> getCurrentUser();

  /// Сохранить пользователя в локальное хранилище
  Future<void> cacheUser(UserModel user);

  /// Удалить пользователя из локального хранилища
  Future<void> clearUser();

  /// Проверить, есть ли сохраненный пользователь
  Future<bool> hasUser();
}

/// Реализация локального источника данных в памяти
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> getCurrentUser() async {
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearUser() async {
    _cachedUser = null;
  }

  @override
  Future<bool> hasUser() async {
    return _cachedUser != null;
  }
}

