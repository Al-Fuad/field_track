import 'package:field_track/features/locations/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.locationName,
    required super.latitude,
    required super.longitude,
    required super.radiusM,
    required super.isActive,
    required super.id,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationName: json['location_name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      radiusM: json['radius_m'] as double,
      isActive: json['is_active'] as bool,
      id: json['id'] as String,
    );
  }

  static List<LocationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => LocationModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'location_name': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'radius_m': radiusM,
      'is_active': isActive,
      'id': id,
    };
  }
}
