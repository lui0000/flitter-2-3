import '../../failures/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Выход из системы
class LogoutUseCase implements UseCaseNoParams<void> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}

