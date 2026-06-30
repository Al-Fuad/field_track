import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/location_model.dart';
part 'locations_event.dart';
part 'locations_state.dart';
class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final List<Location> _locations = [
    const Location(
      id: '1',
      name: 'Downtown Branch',
      latitude: 25.2048,
      longitude: 55.2708,
      radius: 150,
      isActive: true,
    ),
    const Location(
      id: '2',
      name: 'Warehouse',
      latitude: 25.2101,
      longitude: 55.2801,
      radius: 200,
      isActive: true,
    ),
    const Location(
      id: '3',
      name: 'North Depot',
      latitude: 25.1980,
      longitude: 55.2650,
      radius: 120,
      isActive: false,
    ),
  ];
  LocationsBloc() : super(LocationsLoading()) {
    on<LoadLocations>((event, emit) {
      _emitLocations(emit, '');
    });
    on<SearchLocations>((event, emit) {
      _emitLocations(emit, event.query);
    });
    on<AddLocation>((event, emit) {
      _locations.add(event.location);
      String currentQuery = '';
      if (state is LocationsLoaded) {
        currentQuery = (state as LocationsLoaded).searchQuery;
      }
      _emitLocations(emit, currentQuery);
    });
    on<UpdateLocation>((event, emit) {
      final index = _locations.indexWhere((loc) => loc.id == event.location.id);
      if (index != -1) {
        _locations[index] = event.location;
        String currentQuery = '';
        if (state is LocationsLoaded) {
          currentQuery = (state as LocationsLoaded).searchQuery;
        }
        _emitLocations(emit, currentQuery);
      }
    });
    on<DeleteLocation>((event, emit) {
      _locations.removeWhere((loc) => loc.id == event.locationId);
      String currentQuery = '';
      if (state is LocationsLoaded) {
        currentQuery = (state as LocationsLoaded).searchQuery;
      }
      _emitLocations(emit, currentQuery);
    });
  }
  void _emitLocations(Emitter<LocationsState> emit, String query) {
    List<Location> filtered;
    if (query.isEmpty) {
      filtered = List.from(_locations);
    } else {
      filtered = _locations
          .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(LocationsLoaded(
      allLocations: List.from(_locations),
      filteredLocations: filtered,
      searchQuery: query,
    ));
  }
}
