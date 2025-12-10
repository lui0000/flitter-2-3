import '../../entities/access_request_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/access_request_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Обновить статус заявки
class UpdateRequestStatusUseCase implements UseCase<AccessRequestEntity, UpdateStatusParams> {
  final AccessRequestRepository repository;

  UpdateRequestStatusUseCase(this.repository);

  @override
  Future<Either<Failure, AccessRequestEntity>> call(UpdateStatusParams params) async {
    return await repository.updateRequestStatus(
      id: params.requestId,
      newStatus: params.newStatus,
    );
  }
}

/// Параметры для обновления статуса
class UpdateStatusParams {
  final String requestId;
  final AccessRequestStatus newStatus;

  const UpdateStatusParams({
    required this.requestId,
    required this.newStatus,
  });
}

