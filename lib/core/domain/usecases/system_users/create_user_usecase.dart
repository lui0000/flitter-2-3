import '../../entities/system_user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/system_user_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Создать нового пользователя системы
class CreateUserUseCase implements UseCase<SystemUserEntity, CreateUserParams> {
  final SystemUserRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, SystemUserEntity>> call(CreateUserParams params) async {
    // Бизнес-валидация
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure('Имя не может быть пустым'));
    }

    if (params.email.trim().isEmpty) {
      return const Left(ValidationFailure('Email не может быть пустым'));
    }

    if (!_isValidEmail(params.email)) {
      return const Left(ValidationFailure('Неверный формат email'));
    }

    if (params.department.trim().isEmpty) {
      return const Left(ValidationFailure('Отдел должен быть указан'));
    }

    if (params.role.trim().isEmpty) {
      return const Left(ValidationFailure('Роль должна быть указана'));
    }

    return await repository.createUser(
      name: params.name.trim(),
      email: params.email.trim(),
      department: params.department.trim(),
      role: params.role.trim(),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

/// Параметры для создания пользователя
class CreateUserParams {
  final String name;
  final String email;
  final String department;
  final String role;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.department,
    required this.role,
  });
}

