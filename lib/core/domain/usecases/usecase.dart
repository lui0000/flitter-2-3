import '../failures/failure.dart';
import '../utils/either.dart';

/// Базовый класс для всех Use Cases
/// Определяет единый интерфейс для выполнения бизнес-логики
/// Type - тип результата, Params - параметры входа
abstract class UseCase<Type, Params> {
  /// Выполнить use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case без параметров
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Класс для отсутствия параметров
class NoParams {
  const NoParams();
}

