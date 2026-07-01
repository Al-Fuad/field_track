import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:field_track/core/network/token_storage.dart';
import 'package:field_track/core/usecase/usecase.dart';
import 'package:field_track/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/login_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/logout_usecase.dart';
import 'package:field_track/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final GetMeUsecase getMeUsecase;
  final TokenStorage tokenStorage;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.getMeUsecase,
    required this.tokenStorage,
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final token = await tokenStorage.getToken();

    log(token.toString());

    if (token == null || token.isEmpty) {
      emit(AuthUnauthenticated());
      return;
    }

    final result = await getMeUsecase(NoParams());

    result.fold((failure) {
      if (failure.message.contains('Connection failed') ||
          failure.message.contains('network') ||
          failure.message.contains('Failed to connect')) {
        emit(const AuthAuthenticated(name: 'Field User', email: ''));
      } else {
        // unawaited(tokenStorage.removeToken());
        emit(AuthUnauthenticated());
      }
    }, (user) => emit(AuthAuthenticated(name: user.name, email: user.email)));
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUsecase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(error: failure.message)),
      (response) => emit(
        AuthAuthenticated(name: response.user.name, email: response.user.email),
      ),
    );
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await registerUsecase(
      RegisterParams(
        email: event.email,
        password: event.password,
        fullName: event.name,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(error: failure.message)),
      (response) => emit(
        AuthAuthenticated(name: response.user.name, email: response.user.email),
      ),
    );
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    unawaited(tokenStorage.removeToken());
    unawaited(logoutUsecase(NoParams()));
    emit(AuthUnauthenticated());
  }
}
