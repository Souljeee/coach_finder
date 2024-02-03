import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/features/auth/data/remote_models/login_response.dart';
import 'package:dio/dio.dart';

class RemoteAuthDataSource {
  final Dio _networkClient;

  const RemoteAuthDataSource({required Dio networkClient})
      : _networkClient = networkClient;

  Future<LoginResponse> login({
    required String email,
    required String password,
    required AccountType accountType,
  }) async {
    final response = await _networkClient.post(
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
    await _networkClient.post(
      '/logout',
      data: {'email': email},
    );
  }

  Future<bool> checkAuth() async {
    try{
      final response = await _networkClient.get('/check_auth');

      return response.data['hasAccess'];
    }on DioException catch(e, s){
      if(e.response?.statusCode == 401){
        return false;
      }

      Error.throwWithStackTrace(e, s);
    }
  }
}
