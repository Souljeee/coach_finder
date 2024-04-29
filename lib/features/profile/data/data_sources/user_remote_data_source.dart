import 'package:coach_finder/features/profile/data/data_sources/dtos/user_dto.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource {
  final Dio _networkClient;

  const UserRemoteDataSource({required Dio networkClient}) : _networkClient = networkClient;

  Future<UserDto> getUserInfo() async {
    final response = await _networkClient.get('/user_info');

    return UserDto.fromJson(response.data);
  }
}
