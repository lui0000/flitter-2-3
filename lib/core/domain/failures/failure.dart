/// Базовый класс для ошибок в приложении
/// Используется для передачи информации об ошибках между слоями
abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

/// Ошибки сервера
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Ошибки кеша/локального хранилища
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Ошибки валидации
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Ошибки аутентификации
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

/// Ошибки авторизации (доступа)
class AuthorizationFailure extends Failure {
  const AuthorizationFailure(super.message);
}

/// Общие ошибки
class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

