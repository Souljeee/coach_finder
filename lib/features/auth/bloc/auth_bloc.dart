import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/features/auth/common/auth_status.dart';
import 'package:coach_finder/features/auth/data/remote_models/login_response.dart';
import 'package:coach_finder/features/auth/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unauthorized()) {
    on<AuthEvent>(
      (event, emit) => event.map(
        signIn: (event) => _onSignIn(event, emit),
        signOut: (event) => _onSignOut(event, emit),
      ),
    );
  }

  Future<void> _onSignIn(
    _SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthState.processing());

      final LoginResponse loginInfo = await _authRepository.login(
        email: event.email,
        password: event.password,
        accountType: event.accountType,
      );

      if (loginInfo.authStatus == AuthStatus.nonexistent_user) {
        emit(const AuthState.unauthorized(message: 'nonexist'));

        return;
      }

      if (loginInfo.authStatus == AuthStatus.wrong_password) {
        emit(const AuthState.unauthorized(message: 'wrong_password'));

        return;
      }

      emit(const AuthState.authorized());
    } catch (e, s) {
      addError(e, s);

      emit(const AuthState.processing());
    }
  }

  Future<void> _onSignOut(_SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.processing());

      _authRepository.logout(email: event.email);

      emit(const AuthState.unauthorized());
    } catch (e, s) {
      addError(e, s);

      emit(const AuthState.processing());
    }
  }
}
