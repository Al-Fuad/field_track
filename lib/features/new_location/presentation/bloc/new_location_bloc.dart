import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_location_event.dart';
part 'new_location_state.dart';

class NewLocationBloc extends Bloc<NewLocationEvent, NewLocationState> {
  NewLocationBloc() : super(NewLocationInitial()) {
    on<NewLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
