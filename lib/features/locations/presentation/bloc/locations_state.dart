part of 'locations_bloc.dart';
abstract class LocationsState extends Equatable {
  const LocationsState();  

  @override
  List<Object?> get props => [];
}
class LocationsInitial extends LocationsState {}
class LocationsLoading extends LocationsState {}
class LocationsLoaded extends LocationsState {
  final List<Location> allLocations;
  final List<Location> filteredLocations;
  final String searchQuery;
  const LocationsLoaded({
    required this.allLocations,
    required this.filteredLocations,
    this.searchQuery = '',
  });
  @override
  List<Object?> get props => [allLocations, filteredLocations, searchQuery];
}
