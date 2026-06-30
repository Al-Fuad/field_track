import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_location_event.dart';
part 'edit_location_state.dart';

class EditLocationBloc extends Bloc<EditLocationEvent, EditLocationState> {
  EditLocationBloc() : super(EditLocationInitial()) {
    on<EditLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
