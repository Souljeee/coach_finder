import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unauthorized()) {
    on<AuthEvent>(
      (event, emit) => event.map(
        signIn: (event) => _onSignIn(event, emit),
        signOut: (_) => _onSignOut(emit),
      ),
    );
  }

  Future<void> _onSignIn(
    _SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try{
      emit(const AuthState.checkingAuth());

      // TODO: request

      emit(const AuthState.authorized());
    }catch(e, s){
      addError(e, s);

      emit(const AuthState.checkingAuth());
    }
  }

  Future<void> _onSignOut(Emitter<AuthState> emit) async {
    try{
      // TODO: request

      emit(const AuthState.unauthorized());
    }catch(e, s){
      addError(e, s);

      emit(const AuthState.unauthorized());
    }
  }
}
