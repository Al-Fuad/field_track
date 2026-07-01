import 'package:field_track/core/errors/exceptions.dart';
import 'package:field_track/core/failures/failure.dart';
import 'package:field_track/features/locations/data/datasources/location_remote_datasource.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';
import 'package:field_track/features/locations/domain/repositories/location_repository.dart';
import 'package:fpdart/fpdart.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationRemoteDatasource locationRemoteDatasource;

  LocationRepositoryImpl({required this.locationRemoteDatasource});

  @override
  Future<Either<Failure, void>> addLocation(Location location) async {
    try {
      final response = await locationRemoteDatasource.addLocation(location);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocation(String id) async {
    try {
      final response = await locationRemoteDatasource.deleteLocation(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
    try {
      final response = await locationRemoteDatasource.getAllLocations();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateLocation(Location location) async{
    try {
      final response = await locationRemoteDatasource.updateLocation(location);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to connect to the network.'));
    }
  }
}
