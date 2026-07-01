import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllLocationsUsecase implements Usecase<List<Location>, NoParams> {
  final LocationRepository locationRepository;
  GetAllLocationsUsecase({required this.locationRepository});
  @override
  Future<Either<Failure, List<Location>>> call(NoParams params) {
    return locationRepository.getAllLocations();
  }
}