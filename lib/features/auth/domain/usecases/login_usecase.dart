import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/auth/domain/entities/auth_response.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements Usecase<AuthResponse, LoginParams> {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}