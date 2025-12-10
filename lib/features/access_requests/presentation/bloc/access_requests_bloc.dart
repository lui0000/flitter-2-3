import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/approve_access_request.dart' as usecases;
import '../../domain/usecases/create_access_request.dart' as usecases;
import '../../domain/usecases/delete_access_request.dart' as usecases;
import '../../domain/usecases/get_all_access_requests.dart';
import '../../domain/usecases/undo_delete_request.dart';
import 'access_requests_event.dart';
import 'access_requests_state.dart';

class AccessRequestsBloc extends Bloc<AccessRequestsEvent, AccessRequestsState> {
  final GetAllAccessRequests getAllAccessRequests;
  final usecases.CreateAccessRequest createAccessRequestUseCase;
  final usecases.ApproveAccessRequest approveAccessRequestUseCase;
  final usecases.DeleteAccessRequest deleteAccessRequestUseCase;
  final UndoDeleteRequest undoDeleteRequest;

  AccessRequestsBloc({
    required this.getAllAccessRequests,
    required this.createAccessRequestUseCase,
    required this.approveAccessRequestUseCase,
    required this.deleteAccessRequestUseCase,
    required this.undoDeleteRequest,
  }) : super(AccessRequestsInitial()) {
    on<LoadAccessRequests>(_onLoadAccessRequests);
    on<CreateAccessRequest>(_onCreateAccessRequest);
    on<ApproveAccessRequest>(_onApproveAccessRequest);
    on<DeleteAccessRequest>(_onDeleteAccessRequest);
    on<UndoDeleteAccessRequest>(_onUndoDeleteAccessRequest);
  }

  Future<void> _onLoadAccessRequests(
    LoadAccessRequests event,
    Emitter<AccessRequestsState> emit,
  ) async {
    emit(AccessRequestsLoading());

    final result = await getAllAccessRequests(const NoParams());

    result.fold(
      (failure) => emit(AccessRequestsError(failure.message)),
      (requests) => emit(AccessRequestsLoaded(requests)),
    );
  }

  Future<void> _onCreateAccessRequest(
    CreateAccessRequest event,
    Emitter<AccessRequestsState> emit,
  ) async {
    emit(AccessRequestsLoading());

    final params = usecases.CreateAccessRequestParams(
      employee: event.employee,
      accessType: event.accessType,
      description: event.description,
    );

    final result = await createAccessRequestUseCase(params);

    await result.fold(
      (failure) async => emit(AccessRequestsError(failure.message)),
      (_) async {
        emit(AccessRequestCreated());

        add(LoadAccessRequests());
      },
    );
  }


  Future<void> _onApproveAccessRequest(
    ApproveAccessRequest event,
    Emitter<AccessRequestsState> emit,
  ) async {
    emit(AccessRequestsLoading());

    final params = usecases.ApproveAccessRequestParams(event.requestId);
    final result = await approveAccessRequestUseCase(params);

    await result.fold(
      (failure) async => emit(AccessRequestsError(failure.message)),
      (_) async {
        emit(AccessRequestApproved());

        add(LoadAccessRequests());
      },
    );
  }


  Future<void> _onDeleteAccessRequest(
    DeleteAccessRequest event,
    Emitter<AccessRequestsState> emit,
  ) async {
    emit(AccessRequestsLoading());

    final params = usecases.DeleteAccessRequestParams(event.requestId);
    final result = await deleteAccessRequestUseCase(params);

    await result.fold(
      (failure) async => emit(AccessRequestsError(failure.message)),
      (_) async {
        emit(const AccessRequestDeleted(canUndo: true));

        add(LoadAccessRequests());
      },
    );
  }


  Future<void> _onUndoDeleteAccessRequest(
    UndoDeleteAccessRequest event,
    Emitter<AccessRequestsState> emit,
  ) async {
    emit(AccessRequestsLoading());

    final result = await undoDeleteRequest(const NoParams());

    await result.fold(
      (failure) async => emit(AccessRequestsError(failure.message)),
      (_) async {
        add(LoadAccessRequests());
      },
    );
  }
}

