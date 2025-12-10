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

/// Service Locator (контейнер зависимостей)
final sl = GetIt.instance;

/// Инициализация всех зависимостей
/// 
/// Порядок регистрации:
/// 1. Data Sources (внешние источники данных)
/// 2. Repositories (реализации)
/// 3. Use Cases (бизнес-логика)
/// 4. Bloc (управление состоянием)
Future<void> init() async {
  //! ========================================
  //! Features - Access Requests
  //! ========================================

  // ========== Bloc ==========
  // Factory - создается новый экземпляр при каждом вызове
  sl.registerFactory(
    () => AccessRequestsBloc(
      getAllAccessRequests: sl(),
      createAccessRequestUseCase: sl(),
      approveAccessRequestUseCase: sl(),
      deleteAccessRequestUseCase: sl(),
      undoDeleteRequest: sl(),
    ),
  );

  // ========== Use Cases ==========
  // Регистрируем каждый Use Case отдельно
  sl.registerLazySingleton(() => GetAllAccessRequests(sl()));
  sl.registerLazySingleton(() => CreateAccessRequest(sl()));
  sl.registerLazySingleton(() => ApproveAccessRequest(sl()));
  sl.registerLazySingleton(() => DeleteAccessRequest(sl()));
  sl.registerLazySingleton(() => UndoDeleteRequest(sl()));

  // ========== Repository ==========
  // LazySingleton - создается один раз при первом обращении
  sl.registerLazySingleton<AccessRequestRepository>(
    () => AccessRequestRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // ========== Data Sources ==========
  // Singleton - создается сразу и живет все время работы приложения
  sl.registerSingleton<AccessRequestLocalDataSource>(
    AccessRequestLocalDataSourceImpl(),
  );

  //! ========================================
  //! Core (общие зависимости)
  //! ========================================
  // Здесь можно добавить:
  // - Network Info
  // - Shared Preferences
  // - Secure Storage
  // - Logger
  // и т.д.

  //! ========================================
  //! External (внешние библиотеки)
  //! ========================================
  // Здесь можно зарегистрировать:
  // - HTTP Client
  // - Database
  // - Analytics
  // и т.д.
}

