import '../entities/access_request_entity.dart';
import '../failures/failure.dart';
import '../utils/either.dart';

/// Абстрактный репозиторий для работы с заявками на доступ
/// Определяет бизнес-операции без деталей реализации
abstract class AccessRequestRepository {
  /// Получить все заявки
  Future<Either<Failure, List<AccessRequestEntity>>> getAllRequests();

  /// Получить заявку по ID
  Future<Either<Failure, AccessRequestEntity>> getRequestById(String id);

  /// Создать новую заявку
  Future<Either<Failure, AccessRequestEntity>> createRequest({
    required String employeeName,
    required String accessType,
    required String description,
  });

  /// Обновить статус заявки
  Future<Either<Failure, AccessRequestEntity>> updateRequestStatus({
    required String id,
    required AccessRequestStatus newStatus,
  });

  /// Удалить заявку
  Future<Either<Failure, void>> deleteRequest(String id);

  /// Отменить удаление последней заявки (если возможно)
  Future<Either<Failure, AccessRequestEntity?>> undoLastDelete();
}

