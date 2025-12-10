import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/access_request_entity.dart';
import '../../domain/repositories/access_request_repository.dart';
import '../datasources/access_request_local_data_source.dart';
import '../models/access_request_model.dart';

/// Реализация репозитория запросов доступа
/// 
/// Координирует работу с различными источниками данных
/// Обрабатывает ошибки и преобразует их в Failure
/// Скрывает технические детали от Domain Layer
class AccessRequestRepositoryImpl implements AccessRequestRepository {
  final AccessRequestLocalDataSource localDataSource;
  // В будущем можно добавить:
  // final AccessRequestRemoteDataSource remoteDataSource;
  // final NetworkInfo networkInfo;

  AccessRequestRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<AccessRequestEntity>>> getAllRequests() async {
    try {
      final requests = await localDataSource.getAll();
      // Модели автоматически преобразуются в Entity (т.к. Model extends Entity)
      return Right(requests);
    } catch (e) {
      return Left(CacheFailure('Не удалось получить запросы: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AccessRequestEntity>> getRequestById(String id) async {
    try {
      final request = await localDataSource.getById(id);
      return Right(request);
    } catch (e) {
      return Left(CacheFailure('Запрос не найден: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> createRequest({
    required String employee,
    required String accessType,
    required String description,
  }) async {
    try {
      // Создаем модель запроса
      final request = AccessRequestModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        employee: employee,
        accessType: accessType,
        description: description,
        createdAt: DateTime.now(),
        isApproved: false,
      );

      await localDataSource.save(request);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось создать запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> approveRequest(String id) async {
    try {
      // Получаем текущий запрос
      final currentRequest = await localDataSource.getById(id);
      
      // Создаем обновленную версию
      final updatedRequest = AccessRequestModel(
        id: currentRequest.id,
        employee: currentRequest.employee,
        accessType: currentRequest.accessType,
        description: currentRequest.description,
        createdAt: currentRequest.createdAt,
        isApproved: true,
      );

      await localDataSource.update(updatedRequest);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось одобрить запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> rejectRequest(String id) async {
    try {
      // Получаем текущий запрос
      final currentRequest = await localDataSource.getById(id);
      
      // Создаем обновленную версию
      final updatedRequest = AccessRequestModel(
        id: currentRequest.id,
        employee: currentRequest.employee,
        accessType: currentRequest.accessType,
        description: currentRequest.description,
        createdAt: currentRequest.createdAt,
        isApproved: false,
      );

      await localDataSource.update(updatedRequest);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось отклонить запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRequest(String id) async {
    try {
      await localDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось удалить запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> undoDelete() async {
    try {
      // Вызываем метод undoDelete у локального источника данных
      final localSource = localDataSource as AccessRequestLocalDataSourceImpl;
      await localSource.undoDelete();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось отменить удаление: ${e.toString()}'));
    }
  }
}

