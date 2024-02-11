import 'package:coach_finder/features/sign_up/data/local_models/confirm_code_status.dart';
import 'package:coach_finder/features/sign_up/data/local_models/create_account_status.dart';
import 'package:coach_finder/features/sign_up/data/remote_models/create_account_payload.dart';
import 'package:coach_finder/features/sign_up/data/remote_models/create_account_response.dart';
import 'package:dio/dio.dart';

class SignUpDataSource {
  final Dio _networkClient;

  const SignUpDataSource({required Dio networkClient})
      : _networkClient = networkClient;

  Future<CreateAccountStatus> createAccount(
      {required CreateAccountPayload createAccountPayload}) async {
    final response = await _networkClient.post(
      '/create_account',
      data: createAccountPayload.toJson(),
    );

    final CreateAccountResponse createAccountResponse =
        CreateAccountResponse.fromJson(response.data);

    if (createAccountResponse.message == 'User already exist') {
      return CreateAccountStatus.USER_EXIST;
    }

    return CreateAccountStatus.CREATED;
  }

  Future<bool> createCode({required String email}) async {
    final response = await _networkClient.post(
      '/create_code',
      data: {'email': email},
    );

    return response.data['codeSent']!;
  }

  Future<ConfirmCodeStatus> confirmCode({
    required String email,
    required String code,
  }) async {
    final response = await _networkClient.post(
      '/confirm_code',
      data: {
        'email': email,
        'code': code,
      },
    );

    return getConfirmationStatusFromString(
      confirmationStatusString: response.data['confirmationStatus'],
    );
  }
}
