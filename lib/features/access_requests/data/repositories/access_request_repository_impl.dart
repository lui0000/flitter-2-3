import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/access_request_entity.dart';
import '../../domain/repositories/access_request_repository.dart';
import '../datasources/access_request_local_data_source.dart';
import '../datasources/api/dto/access_request_dto.dart';
import '../datasources/api/mappers/access_request_mapper.dart';

class AccessRequestRepositoryImpl implements AccessRequestRepository {
  final AccessRequestLocalDataSource localDataSource;

  AccessRequestRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<AccessRequestEntity>>> getAllRequests() async {
    try {
      final dtoList = await localDataSource.getAll();
      final entities = AccessRequestMapper.toEntityList(dtoList);
      return Right(entities);
    } catch (e) {
      return Left(CacheFailure('Не удалось получить запросы: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AccessRequestEntity>> getRequestById(String id) async {
    try {
      final dto = await localDataSource.getById(id);
      final entity = AccessRequestMapper.toEntity(dto);
      return Right(entity);
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
      final dto = AccessRequestDTO(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        employee: employee,
        accessType: accessType,
        description: description,
        createdAt: DateTime.now().toIso8601String(),
        isApproved: false,
      );

      await localDataSource.save(dto);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось создать запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> approveRequest(String id) async {
    try {

      final currentDto = await localDataSource.getById(id);

      final updatedDto = AccessRequestDTO(
        id: currentDto.id,
        employee: currentDto.employee,
        accessType: currentDto.accessType,
        description: currentDto.description,
        createdAt: currentDto.createdAt,
        isApproved: true,
      );

      await localDataSource.update(updatedDto);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось одобрить запрос: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> rejectRequest(String id) async {
    try {
      final currentDto = await localDataSource.getById(id);
      final updatedDto = AccessRequestDTO(
        id: currentDto.id,
        employee: currentDto.employee,
        accessType: currentDto.accessType,
        description: currentDto.description,
        createdAt: currentDto.createdAt,
        isApproved: false,
      );

      await localDataSource.update(updatedDto);
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
      final localSource = localDataSource as AccessRequestLocalDataSourceImpl;
      await localSource.undoDelete();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Не удалось отменить удаление: ${e.toString()}'));
    }
  }
}
