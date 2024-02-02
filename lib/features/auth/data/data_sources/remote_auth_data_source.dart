import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/features/auth/data/remote_models/login_response.dart';
import 'package:dio/dio.dart';

class RemoteAuthDataSource {
  final Dio networkClient;

  const RemoteAuthDataSource({required this.networkClient});

  Future<LoginResponse> login({
    required String email,
    required String password,
    required AccountType accountType,
  }) async {
    final response = await networkClient.post(
      '/login',
      data: {
        'email': email,
        'password': password,
        'accountType': accountType,
      },
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<void> logout({required String email}) async {
    await networkClient.post(
      '/logout',
      data: {'email': email},
    );
  }
}
