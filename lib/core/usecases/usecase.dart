import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

@immutable
class NoParams {
  const NoParams();
}

