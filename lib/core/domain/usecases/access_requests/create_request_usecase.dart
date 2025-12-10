import '../../entities/access_request_entity.dart';
import '../../failures/failure.dart';
import '../../repositories/access_request_repository.dart';
import '../../utils/either.dart';
import '../usecase.dart';

/// Use Case: Создать заявку на доступ
class CreateRequestUseCase implements UseCase<AccessRequestEntity, CreateRequestParams> {
  final AccessRequestRepository repository;

  CreateRequestUseCase(this.repository);

  @override
  Future<Either<Failure, AccessRequestEntity>> call(CreateRequestParams params) async {
    // Бизнес-валидация
    if (params.employeeName.trim().isEmpty) {
      return const Left(ValidationFailure('Имя сотрудника не может быть пустым'));
    }

    if (params.accessType.trim().isEmpty) {
      return const Left(ValidationFailure('Тип доступа должен быть указан'));
    }

    // Делегирование репозиторию
    return await repository.createRequest(
      employeeName: params.employeeName.trim(),
      accessType: params.accessType.trim(),
      description: params.description.trim(),
    );
  }
}

/// Параметры для создания заявки
class CreateRequestParams {
  final String employeeName;
  final String accessType;
  final String description;

  const CreateRequestParams({
    required this.employeeName,
    required this.accessType,
    required this.description,
  });
}

