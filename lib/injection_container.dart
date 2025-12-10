import 'package:get_it/get_it.dart';

// Features - Access Requests
import 'features/access_requests/data/datasources/access_request_local_data_source.dart';
import 'features/access_requests/data/repositories/access_request_repository_impl.dart';
import 'features/access_requests/domain/repositories/access_request_repository.dart';
import 'features/access_requests/domain/usecases/approve_access_request.dart';
import 'features/access_requests/domain/usecases/create_access_request.dart';
import 'features/access_requests/domain/usecases/delete_access_request.dart';
import 'features/access_requests/domain/usecases/get_all_access_requests.dart';
import 'features/access_requests/domain/usecases/undo_delete_request.dart';
import 'features/access_requests/presentation/bloc/access_requests_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => AccessRequestsBloc(
      getAllAccessRequests: sl(),
      createAccessRequestUseCase: sl(),
      approveAccessRequestUseCase: sl(),
      deleteAccessRequestUseCase: sl(),
      undoDeleteRequest: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllAccessRequests(sl()));
  sl.registerLazySingleton(() => CreateAccessRequest(sl()));
  sl.registerLazySingleton(() => ApproveAccessRequest(sl()));
  sl.registerLazySingleton(() => DeleteAccessRequest(sl()));
  sl.registerLazySingleton(() => UndoDeleteRequest(sl()));

  sl.registerLazySingleton<AccessRequestRepository>(
    () => AccessRequestRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  sl.registerSingleton<AccessRequestLocalDataSource>(
    AccessRequestLocalDataSourceImpl(),
  );

}

