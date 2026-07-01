import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/network/token_storage.dart';
import 'package:field_track/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:field_track/features/auth/domain/entities/auth_response.dart';
import 'package:field_track/features/auth/domain/entities/user.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl({
    required this.authRemoteDatasource,
    required this.tokenStorage,
  });

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await authRemoteDatasource.login(email, password);
      await tokenStorage.saveToken(authResponse.accessToken);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final response = await authRemoteDatasource.logout();
      await tokenStorage.removeToken();
      return Right(response);
    } on ServerException catch (e) {
      await tokenStorage.removeToken();
      return Left(ServerFailure(e.message));
    } catch (e) {
      await tokenStorage.removeToken();
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, User>> me() async {
    try {
      final user = await authRemoteDatasource.me();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final authResponse = await authRemoteDatasource.register(email, password, fullName);
      await tokenStorage.saveToken(authResponse.accessToken);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }
}
