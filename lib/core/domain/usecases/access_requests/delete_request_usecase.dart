import '../../failures/failure.dart';
import '../../repositories/access_request_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Удалить заявку
class DeleteRequestUseCase implements UseCase<void, String> {
  final AccessRequestRepository repository;

  DeleteRequestUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String requestId) async {
    if (requestId.isEmpty) {
      return const Left(ValidationFailure('ID заявки не может быть пустым'));
    }

    return await repository.deleteRequest(requestId);
  }
}

