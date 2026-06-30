part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {
  const LocationsState();  

  @override
  List<Object> get props => [];
}
class LocationsInitial extends LocationsState {}
