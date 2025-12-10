import '../../entities/user_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/auth_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Вход в систему
/// Инкапсулирует бизнес-логику авторизации
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    // Валидация на уровне бизнес-логики
    if (params.email.isEmpty) {
      return const Left(ValidationFailure('Email не может быть пустым'));
    }

    if (!_isValidEmail(params.email)) {
      return const Left(ValidationFailure('Неверный формат email'));
    }

    if (params.password.length < 4) {
      return const Left(ValidationFailure('Пароль должен содержать минимум 4 символа'));
    }

    // Делегирование репозиторию
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

/// Параметры для входа
class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

