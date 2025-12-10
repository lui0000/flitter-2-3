import '../entities/system_user_entity.dart';
import '../failures/failure.dart';
import '../utils/either.dart';

/// Абстрактный репозиторий для управления пользователями системы
/// Бизнес-контракт без технических деталей
abstract class SystemUserRepository {
  /// Получить всех пользователей системы
  Future<Either<Failure, List<SystemUserEntity>>> getAllUsers();

  /// Получить пользователя по ID
  Future<Either<Failure, SystemUserEntity>> getUserById(String id);

  /// Создать нового пользователя
  Future<Either<Failure, SystemUserEntity>> createUser({
    required String name,
    required String email,
    required String department,
    required String role,
  });

  /// Обновить пользователя
  Future<Either<Failure, SystemUserEntity>> updateUser(SystemUserEntity user);

  /// Переключить активность пользователя
  Future<Either<Failure, SystemUserEntity>> toggleUserActive(String id);

  /// Удалить пользователя
  Future<Either<Failure, void>> deleteUser(String id);

  /// Поиск пользователей по запросу
  Future<Either<Failure, List<SystemUserEntity>>> searchUsers(String query);
}

