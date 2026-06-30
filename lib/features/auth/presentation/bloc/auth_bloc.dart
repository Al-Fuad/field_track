import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      // Simulate network call
      await Future.delayed(const Duration(seconds: 1));
      if (event.email.isNotEmpty && event.password.length >= 6) {
        // Mock user details based on email
        final name = event.email.split('@').first;
        final capitalizedName = name.isEmpty 
            ? ''
            : '${name[0].toUpperCase()}${name.substring(1)}';
        emit(AuthAuthenticated(name: capitalizedName, email: event.email));
      } else {
        emit(const AuthFailure(error: 'Invalid email or password (min 6 chars)'));
      }
    });
    on<AuthRegisterRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.name.isNotEmpty && event.email.isNotEmpty && event.password.length >= 6) {
        emit(AuthAuthenticated(name: event.name, email: event.email));
      } else {
        emit(const AuthFailure(error: 'Please fill in all fields correctly (password min 6 chars)'));
      }
    });
    on<AuthLogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
