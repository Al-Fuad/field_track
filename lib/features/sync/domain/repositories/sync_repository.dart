import 'package:field_track/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class SyncRepository {
  Future<Either<Failure, void>> syncAll();
}