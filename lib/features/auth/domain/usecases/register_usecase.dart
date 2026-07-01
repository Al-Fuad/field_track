import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/auth/domain/entities/auth_response.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase implements Usecase<AuthResponse, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});
  @override
  Future<Either<Failure, AuthResponse>> call(RegisterParams params) async {
    return await authRepository.register(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String fullName;
  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
  });
}