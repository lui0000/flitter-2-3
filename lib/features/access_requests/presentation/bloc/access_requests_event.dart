import 'package:equatable/equatable.dart';

/// Базовое событие для Access Requests
abstract class AccessRequestsEvent extends Equatable {
  const AccessRequestsEvent();

  @override
  List<Object?> get props => [];
}

/// Загрузить все запросы
class LoadAccessRequests extends AccessRequestsEvent {}

/// Создать новый запрос
class CreateAccessRequest extends AccessRequestsEvent {
  final String employee;
  final String accessType;
  final String description;

  const CreateAccessRequest({
    required this.employee,
    required this.accessType,
    required this.description,
  });

  @override
  List<Object?> get props => [employee, accessType, description];
}

/// Одобрить запрос
class ApproveAccessRequest extends AccessRequestsEvent {
  final String requestId;

  const ApproveAccessRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

/// Отклонить запрос
class RejectAccessRequest extends AccessRequestsEvent {
  final String requestId;

  const RejectAccessRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

/// Удалить запрос
class DeleteAccessRequest extends AccessRequestsEvent {
  final String requestId;

  const DeleteAccessRequest(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

/// Отменить удаление
class UndoDeleteAccessRequest extends AccessRequestsEvent {}



