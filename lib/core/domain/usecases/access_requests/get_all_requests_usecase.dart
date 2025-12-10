import '../../entities/access_request_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/access_request_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Получить все заявки на доступ
class GetAllRequestsUseCase implements UseCaseNoParams<List<AccessRequestEntity>> {
  final AccessRequestRepository repository;

  GetAllRequestsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AccessRequestEntity>>> call() async {
    return await repository.getAllRequests();
  }
}

