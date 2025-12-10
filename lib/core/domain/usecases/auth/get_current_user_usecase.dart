import '../../entities/user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Получить текущего пользователя
class GetCurrentUserUseCase implements UseCaseNoParams<UserEntity?> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}

