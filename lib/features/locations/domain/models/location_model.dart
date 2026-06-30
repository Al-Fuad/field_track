import 'package:equatable/equatable.dart';
class Location extends Equatable {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double radius; // in meters
  final bool isActive;
  const Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.isActive,
  });
  Location copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    double? radius,
    bool? isActive,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      isActive: isActive ?? this.isActive,
    );
  }
  @override
  List<Object?> get props => [id, name, latitude, longitude, radius, isActive];
}
