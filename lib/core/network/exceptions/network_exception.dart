class NetworkException implements Exception {
  final String message;
  final dynamic data;

  NetworkException(this.message, {this.data});

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException extends NetworkException {
  TimeoutException([String message = 'Connection timeout']) : super(message);
}

class BadRequestException extends NetworkException {
  BadRequestException([String message = 'Bad request', dynamic data])
      : super(message, data: data);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([String message = 'Unauthorized', dynamic data])
      : super(message, data: data);
}

class ServerException extends NetworkException {
  ServerException([String message = 'Server error', dynamic data])
      : super(message, data: data);
}

