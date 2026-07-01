import 'package:field_track/core/network/api_client.dart';
import 'package:field_track/features/locations/domain/entities/location.dart';

abstract class LocationRemoteDatasource {
  Future<List<Location>> getAllLocations();
  Future<void> addLocation(Location location);
  Future<void> updateLocation(Location location);
  Future<void> deleteLocation(String id);
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final ApiClient apiClient;
  LocationRemoteDatasourceImpl({required this.apiClient});
  
  @override
  Future<void> addLocation(Location location) {
    // TODO: implement addLocation
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteLocation(String id) {
    // TODO: implement deleteLocation
    throw UnimplementedError();
  }
  
  @override
  Future<List<Location>> getAllLocations() {
    // TODO: implement getAllLocations
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateLocation(Location location) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }
}