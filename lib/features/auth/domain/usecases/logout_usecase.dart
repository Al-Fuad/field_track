import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements Usecase<bool, NoParams> {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.logout();
  }
}