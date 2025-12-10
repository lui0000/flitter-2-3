import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/access_request_repository.dart';

class DeleteAccessRequest implements UseCase<void, DeleteAccessRequestParams> {
  final AccessRequestRepository repository;

  DeleteAccessRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteAccessRequestParams params) async {
    if (params.requestId.trim().isEmpty) {
      return const Left(ValidationFailure('ID запроса не может быть пустым'));
    }

    return await repository.deleteRequest(params.requestId);
  }
}

class DeleteAccessRequestParams extends Equatable {
  final String requestId;

  const DeleteAccessRequestParams(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

