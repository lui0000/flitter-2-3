import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/access_request_repository.dart';

class UndoDeleteRequest implements UseCase<void, NoParams> {
  final AccessRequestRepository repository;

  UndoDeleteRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.undoDelete();
  }
}

