import 'package:coach_finder/features/auth/data/remote_models/login_response.dart';
import 'package:dio/dio.dart';

class RemoteAuthDataSource{
  final Dio networkClient;
  const RemoteAuthDataSource({required this.networkClient});

  Future<LoginResponse> login() async {
    final response  = await networkClient.post('path');

    return LoginResponse.fromJson(response.data);
  }
}