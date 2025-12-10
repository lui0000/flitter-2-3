import '../entities/user_entity.dart';
import '../failures/failure.dart';
import '../utils/either.dart';

/// Абстрактный репозиторий для аутентификации
/// Определяет контракт на языке бизнеса, без технических деталей
/// Реализация будет в Data Layer
abstract class AuthRepository {
  /// Вход в систему
  /// Возвращает Either: Left с ошибкой или Right с пользователем
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Регистрация нового пользователя
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  });

  /// Выход из системы
  Future<Either<Failure, void>> logout();

  /// Получить текущего пользователя
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Проверка, авторизован ли пользователь
  Future<bool> isLoggedIn();
}

