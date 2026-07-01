import 'package:field_track/core/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {
  const NoParams();
}