import '../entities/access_request_entity.dart';
import '../failures/failure.dart';
import '../utils/either.dart';

abstract class AccessRequestRepository {
  Future<Either<Failure, List<AccessRequestEntity>>> getAllRequests();
  Future<Either<Failure, AccessRequestEntity>> getRequestById(String id);

  Future<Either<Failure, AccessRequestEntity>> createRequest({
    required String employeeName,
    required String accessType,
    required String description,
  });

  Future<Either<Failure, AccessRequestEntity>> updateRequestStatus({
    required String id,
    required AccessRequestStatus newStatus,
  });

  Future<Either<Failure, void>> deleteRequest(String id);

  Future<Either<Failure, AccessRequestEntity?>> undoLastDelete();
}

