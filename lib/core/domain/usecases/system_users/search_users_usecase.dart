import '../../entities/system_user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/system_user_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Поиск пользователей
class SearchUsersUseCase implements UseCase<List<SystemUserEntity>, String> {
  final SystemUserRepository repository;

  SearchUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<SystemUserEntity>>> call(String query) async {
    // Если запрос пустой, возвращаем всех пользователей
    return await repository.searchUsers(query.trim());
  }
}

