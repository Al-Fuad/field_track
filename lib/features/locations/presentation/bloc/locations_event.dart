part of 'locations_bloc.dart';
abstract class LocationsEvent extends Equatable {
  const LocationsEvent();
  @override
  List<Object?> get props => [];
}
class LoadLocations extends LocationsEvent {}
class SearchLocations extends LocationsEvent {
  final String query;
  const SearchLocations(this.query);
  @override
  List<Object?> get props => [query];
}
class AddLocation extends LocationsEvent {
  final Location location;
  const AddLocation(this.location);
  @override
  List<Object?> get props => [location];
}
class UpdateLocation extends LocationsEvent {
  final Location location;
  const UpdateLocation(this.location);
  @override
  List<Object?> get props => [location];
}
class DeleteLocation extends LocationsEvent {
  final String locationId;
  const DeleteLocation(this.locationId);
  @override
  List<Object?> get props => [locationId];
}
