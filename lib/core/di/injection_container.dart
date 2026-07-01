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

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: sl(),
      tokenStorage: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => GetMeUsecase(authRepository: sl()));

  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      loginUsecase: sl(),
      registerUsecase: sl(),
      logoutUsecase: sl(),
      getMeUsecase: sl(),
    ),
  );

  sl.registerFactory(() => TasksBloc());
  sl.registerFactory(() => LocationsBloc());
  sl.registerFactory(() => SyncBloc());
}
