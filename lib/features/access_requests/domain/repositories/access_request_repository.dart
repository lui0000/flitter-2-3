import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/access_request_entity.dart';

abstract class AccessRequestRepository {
  Future<Either<Failure, List<AccessRequestEntity>>> getAllRequests();

  Future<Either<Failure, AccessRequestEntity>> getRequestById(String id);

  Future<Either<Failure, void>> createRequest({
    required String employee,
    required String accessType,
    required String description,
  });

  Future<Either<Failure, void>> approveRequest(String id);

  Future<Either<Failure, void>> rejectRequest(String id);

  Future<Either<Failure, void>> deleteRequest(String id);

  Future<Either<Failure, void>> undoDelete();
}

