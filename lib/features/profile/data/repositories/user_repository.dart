import 'package:coach_finder/features/profile/data/data_sources/dtos/user_dto.dart';
import 'package:coach_finder/features/profile/data/data_sources/user_remote_data_source.dart';

class UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  const UserRepository({required UserRemoteDataSource userRemoteDataSource})
      : _userRemoteDataSource = userRemoteDataSource;

  Future<UserDto> getUser() async {
    return _userRemoteDataSource.getUserInfo();
  }
}
