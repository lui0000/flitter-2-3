import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/access_request_repository.dart';

class ApproveAccessRequest implements UseCase<void, ApproveAccessRequestParams> {
  final AccessRequestRepository repository;

  ApproveAccessRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(ApproveAccessRequestParams params) async {
    if (params.requestId.trim().isEmpty) {
      return const Left(ValidationFailure('ID запроса не может быть пустым'));
    }

    return await repository.approveRequest(params.requestId);
  }
}

class ApproveAccessRequestParams extends Equatable {
  final String requestId;

  const ApproveAccessRequestParams(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

