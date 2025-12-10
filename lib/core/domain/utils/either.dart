/// Класс Either для представления результата операции
/// Left - ошибка, Right - успешный результат
/// Паттерн функционального программирования для обработки ошибок
abstract class Either<L, R> {
  const Either();
  
  /// Проверка на успешный результат
  bool get isRight => this is Right<L, R>;
  
  /// Проверка на ошибку
  bool get isLeft => this is Left<L, R>;
  
  /// Получить значение Left (ошибку) или null
  L? get leftOrNull => isLeft ? (this as Left<L, R>).value : null;
  
  /// Получить значение Right (результат) или null
  R? get rightOrNull => isRight ? (this as Right<L, R>).value : null;
  
  /// Выполнить функцию в зависимости от результата
  T fold<T>(T Function(L left) ifLeft, T Function(R right) ifRight);
}

/// Левая часть (ошибка)
class Left<L, R> extends Either<L, R> {
  final L value;
  
  const Left(this.value);
  
  @override
  T fold<T>(T Function(L left) ifLeft, T Function(R right) ifRight) {
    return ifLeft(value);
  }
}

/// Правая часть (успешный результат)
class Right<L, R> extends Either<L, R> {
  final R value;
  
  const Right(this.value);
  
  @override
  T fold<T>(T Function(L left) ifLeft, T Function(R right) ifRight) {
    return ifRight(value);
  }
}

