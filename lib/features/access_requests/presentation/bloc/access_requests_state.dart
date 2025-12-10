import 'package:equatable/equatable.dart';
import '../../domain/entities/access_request_entity.dart';

/// Базовое состояние для Access Requests
abstract class AccessRequestsState extends Equatable {
  const AccessRequestsState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class AccessRequestsInitial extends AccessRequestsState {}

/// Состояние загрузки
class AccessRequestsLoading extends AccessRequestsState {}

/// Успешная загрузка запросов
class AccessRequestsLoaded extends AccessRequestsState {
  final List<AccessRequestEntity> requests;

  const AccessRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

/// Состояние ошибки
class AccessRequestsError extends AccessRequestsState {
  final String message;

  const AccessRequestsError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Успешное создание запроса
class AccessRequestCreated extends AccessRequestsState {}

/// Успешное одобрение запроса
class AccessRequestApproved extends AccessRequestsState {}

/// Успешное удаление запроса
class AccessRequestDeleted extends AccessRequestsState {
  final bool canUndo;

  const AccessRequestDeleted({this.canUndo = true});

  @override
  List<Object?> get props => [canUndo];
}

