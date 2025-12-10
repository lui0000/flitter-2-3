import '../../entities/system_user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/system_user_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Получить всех пользователей системы
class GetAllUsersUseCase implements UseCaseNoParams<List<SystemUserEntity>> {
  final SystemUserRepository repository;

  GetAllUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<SystemUserEntity>>> call() async {
    return await repository.getAllUsers();
  }
}

