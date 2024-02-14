import 'dart:async';

import 'package:coach_finder/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:coach_finder/features/sign_up/data/local_models/confirm_code_status.dart';
import 'package:coach_finder/features/sign_up/data/local_models/create_account_status.dart';
import 'package:coach_finder/features/sign_up/data/remote_models/create_account_payload.dart';

class SignUpRepository {
  final SignUpDataSource _signUpDataSource;

  SignUpRepository({
    required SignUpDataSource signUpDataSource,
  }) : _signUpDataSource = signUpDataSource;

  Future<CreateAccountStatus> createAccount({
    required CreateAccountPayload createAccountPayload,
  }) async {
    return _signUpDataSource.createAccount(createAccountPayload: createAccountPayload);
  }

  Future<bool> createCode({required String email}) async {
    return _signUpDataSource.createCode(email: email);
  }

  Future<ConfirmCodeStatus> confirmCode({
    required String email,
    required String code,
  }) async {
    return _signUpDataSource.confirmCode(email: email, code: code);
  }
}
