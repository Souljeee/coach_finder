import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/features/sign_up/bloc/models/errors_type_enums.dart';
import 'package:coach_finder/features/sign_up/data/local_models/confirm_code_status.dart';
import 'package:coach_finder/features/sign_up/data/local_models/create_account_status.dart';
import 'package:coach_finder/features/sign_up/data/remote_models/create_account_payload.dart';
import 'package:coach_finder/features/sign_up/data/repository/sign_up_repository.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository _signUpRepository;

  SignUpBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(const SignUpState.idle()) {
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
      emit(const SignUpState.codeCreating());

      final CreateAccountStatus accountCreatedStatus = await _signUpRepository.createAccount(
        createAccountPayload: CreateAccountPayload(
          email: event.email,
          password: event.password,
          accountType: event.accountType,
        ),
      );

      if (accountCreatedStatus == CreateAccountStatus.USER_EXIST) {
        emit(
          const SignUpState.codeCreatingError(
            errorType: CodeCreatingErrorType.USER_EXIST,
          ),
        );

        return;
      }

      final bool isCodeSent = await _signUpRepository.createCode(email: event.email);

      if (!isCodeSent) {
        emit(
          const SignUpState.codeCreatingError(
            errorType: CodeCreatingErrorType.UNDEFINED,
          ),
        );

        return;
      }

      emit(SignUpState.codeCreated(email: event.email));
    } catch (e, s) {
      addError(e, s);

      emit(
        const SignUpState.codeCreatingError(
          errorType: CodeCreatingErrorType.UNDEFINED,
        ),
      );
    }
  }

  Future<void> _onCodeConfirmRequested(
    _CodeConfirmRequestedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(const SignUpState.codeConfirming());

      await Future.delayed(const Duration(seconds: 1));

      final ConfirmCodeStatus confirmationStatus = await _signUpRepository.confirmCode(
        email: event.email,
        code: event.code,
      );

      if(confirmationStatus == ConfirmCodeStatus.WRONG_CODE){
        emit(const SignUpState.confirmationError(reason: CodeConfirmingErrorType.WRONG_CODE));
      }

      emit(const SignUpState.codeConfirmed());
    } catch (e, s) {
      addError(e, s);

      emit(const SignUpState.confirmationError(reason: CodeConfirmingErrorType.UNDEFINED));
    }
  }
}
