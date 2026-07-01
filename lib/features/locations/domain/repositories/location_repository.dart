import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';
import 'package:fpdart/fpdart.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();
  Future<Either<Failure, void>> addLocation(Location location);
  Future<Either<Failure, void>> updateLocation(Location location);
  Future<Either<Failure, void>> deleteLocation(String id);
}