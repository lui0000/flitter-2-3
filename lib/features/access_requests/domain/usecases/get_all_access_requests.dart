import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/access_request_entity.dart';
import '../repositories/access_request_repository.dart';

class GetAllAccessRequests implements UseCase<List<AccessRequestEntity>, NoParams> {
  final AccessRequestRepository repository;

  GetAllAccessRequests(this.repository);

  @override
  Future<Either<Failure, List<AccessRequestEntity>>> call(NoParams params) async {
    return await repository.getAllRequests();
  }
}

