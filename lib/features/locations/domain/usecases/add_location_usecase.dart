import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddLocationUsecase implements Usecase<void, AddLocationUsecaseParams> {
  final LocationRepository locationRepository;
  AddLocationUsecase({required this.locationRepository});
  @override
  Future<Either<Failure, void>> call(AddLocationUsecaseParams params) {
    return locationRepository.addLocation(params.location);
  }
}

class AddLocationUsecaseParams {
  final Location location;
  AddLocationUsecaseParams({required this.location});
}