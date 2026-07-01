import 'package:field_track/features/locations/data/datasources/location_remote_datasource.dart';
import 'package:field_track/features/locations/data/repositories/location_repository_impl.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:field_track/features/locations/domain/usecases/add_location_usecase.dart';
import 'package:field_track/features/locations/domain/usecases/delete_location_usecase.dart';
import 'package:field_track/features/locations/domain/usecases/get_all_locations_usecase.dart';
import 'package:field_track/features/locations/domain/usecases/update_location_usecase.dart';
import 'package:field_track/features/sync/data/datasources/sync_remote_datasource.dart';
import 'package:field_track/features/sync/data/repositories/sync_repository_impl.dart';
import 'package:field_track/features/sync/domain/repositories/sync_repository.dart';
import 'package:field_track/features/sync/domain/usecases/sync_all_usecase.dart';
import 'package:field_track/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:field_track/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:field_track/features/tasks/domain/repositories/task_repository.dart';
import 'package:field_track/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:field_track/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:field_track/core/network/api_client.dart';
import 'package:field_track/core/network/token_storage.dart';
import 'package:field_track/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:field_track/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:field_track/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/login_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/logout_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/register_usecase.dart';
import 'package:field_track/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:field_track/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:field_track/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:field_track/features/sync/presentation/bloc/sync_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Core / Network
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(tokenStorage: sl()));

  // Features - Auth
  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<TaskRemoteDatasource>(
    () => TaskRemoteDatasourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<LocationRemoteDatasource>(
    () => LocationRemoteDatasourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<SyncRemoteDatasource>(
    () => SyncRemoteDatasourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: sl(), tokenStorage: sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(taskRemoteDatasource: sl()),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(locationRemoteDatasource: sl()),
  );
  sl.registerLazySingleton<SyncRepository>(
    () => SyncRepositoryImpl(syncRemoteDatasource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => GetMeUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => GetAllTasksUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => AddLocationUsecase(locationRepository: sl()));
  sl.registerLazySingleton(
    () => DeleteLocationUsecase(locationRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetAllLocationsUsecase(locationRepository: sl()),
  );
  sl.registerLazySingleton(
    () => UpdateLocationUsecase(locationRepository: sl()),
  );
  sl.registerLazySingleton(() => SyncAllUsecase(syncRepository: sl()));

  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      loginUsecase: sl(),
      registerUsecase: sl(),
      logoutUsecase: sl(),
      getMeUsecase: sl(),
      tokenStorage: sl(),
    ),
  );

  sl.registerFactory(
    () => TasksBloc(getAllTasksUsecase: sl(), updateTaskUsecase: sl()),
  );

  sl.registerFactory(
    () => LocationsBloc(
      getAllLocationsUsecase: sl(),
      addLocationUsecase: sl(),
      updateLocationUsecase: sl(),
      deleteLocationUsecase: sl(),
    ),
  );
  sl.registerFactory(() => SyncBloc(syncAllUsecase: sl()));
}
