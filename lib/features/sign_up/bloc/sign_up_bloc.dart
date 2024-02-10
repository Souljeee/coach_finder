import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/common/data/account_type.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.idle()) {
    on<SignUpEvent>(
      (event, emit) => event.map(
        createCodeRequested: (event) => _onCreateCodeRequested(event, emit),
        codeConfirmRequested: (event) => _onCodeConfirmRequested(event, emit),
      ),
    );
  }

  Future<void> _onCreateCodeRequested(
    _CreateCodeRequestedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(const SignUpState.processing());

      // do something

      emit(const SignUpState.codeCreated());
    } catch (e, s) {
      addError(e, s);

      emit(const SignUpState.error());
    }
  }

  Future<void> _onCodeConfirmRequested(
    _CodeConfirmRequestedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(const SignUpState.codeConfirming());

      // do something

      emit(const SignUpState.codeConfirming());
    } catch (e, s) {
      addError(e, s);

      emit(const SignUpState.error());
    }
  }
}
