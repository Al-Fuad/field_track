import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateLocationUsecase implements Usecase<void, UpdateLocationUsecaseParams> {
  final LocationRepository locationRepository;
  UpdateLocationUsecase({required this.locationRepository});
  @override
  Future<Either<Failure, void>> call(UpdateLocationUsecaseParams params) {
    return locationRepository.updateLocation(params.location);
  }
}

class UpdateLocationUsecaseParams {
  final Location location;
  UpdateLocationUsecaseParams({required this.location});
}