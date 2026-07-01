
class Location {
  final String locationName;
  final double latitude;
  final double longitude;
  final double radiusM;
  final bool isActive;
  final String id;
  const Location({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
    required this.isActive,
    required this.id,
  });
}
