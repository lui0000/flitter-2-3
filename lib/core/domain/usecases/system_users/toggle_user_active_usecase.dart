import '../../entities/system_user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/system_user_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Переключить активность пользователя
class ToggleUserActiveUseCase implements UseCase<SystemUserEntity, String> {
  final SystemUserRepository repository;

  ToggleUserActiveUseCase(this.repository);

  @override
  Future<Either<Failure, SystemUserEntity>> call(String userId) async {
    if (userId.isEmpty) {
      return const Left(ValidationFailure('ID пользователя не может быть пустым'));
    }

    return await repository.toggleUserActive(userId);
  }
}

