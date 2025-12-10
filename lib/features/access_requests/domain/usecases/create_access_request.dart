import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/access_request_repository.dart';

class CreateAccessRequest implements UseCase<void, CreateAccessRequestParams> {
  final AccessRequestRepository repository;

  CreateAccessRequest(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateAccessRequestParams params) async {
    final validationResult = _validateParams(params);
    if (validationResult != null) {
      return Left(validationResult);
    }

    return await repository.createRequest(
      employee: params.employee,
      accessType: params.accessType,
      description: params.description,
    );
  }

  Failure? _validateParams(CreateAccessRequestParams params) {
    if (params.employee.trim().isEmpty) {
      return const ValidationFailure('Имя сотрудника не может быть пустым');
    }
    
    if (params.employee.trim().length < 3) {
      return const ValidationFailure('Имя сотрудника должно содержать минимум 3 символа');
    }

    if (params.accessType.trim().isEmpty) {
      return const ValidationFailure('Тип доступа не может быть пустым');
    }

    return null;
  }
}

class CreateAccessRequestParams extends Equatable {
  final String employee;
  final String accessType;
  final String description;

  const CreateAccessRequestParams({
    required this.employee,
    required this.accessType,
    required this.description,
  });

  @override
  List<Object?> get props => [employee, accessType, description];
}

