import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/auth/domain/entities/auth_response.dart';
import 'package:field_track/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> register({
    required String email,
    required String password,
    required String fullName,
  });
  
  Future<Either<Failure, User>> me();

  Future<Either<Failure, bool>> logout();
}