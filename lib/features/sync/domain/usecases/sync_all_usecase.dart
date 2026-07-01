import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/sync/domain/repositories/sync_repository.dart';
import 'package:fpdart/fpdart.dart';

class SyncAllUsecase implements Usecase<void, NoParams> {
  final SyncRepository syncRepository;
  SyncAllUsecase({required this.syncRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return syncRepository.syncAll();
  }
}