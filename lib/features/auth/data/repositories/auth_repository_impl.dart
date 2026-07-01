import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:field_track/features/auth/domain/entities/auth_response.dart';
import 'package:field_track/features/auth/domain/entities/user.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl({required this._authRemoteDatasource});

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _authRemoteDatasource.login(email, password);
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
      final response = await _authRemoteDatasource.logout();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, User>> me() async {
    try {
      final user = await _authRemoteDatasource.me();
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
      final authResponse = await _authRemoteDatasource.register(email, password, fullName);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }
}
