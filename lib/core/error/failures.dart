abstract class Failure {
  final String message;
  
  const Failure(this.message);
  
  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Ошибка сервера']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Ошибка кэша']) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Ошибка сети']) : super(message);
}

