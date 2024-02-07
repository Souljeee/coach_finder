import 'dart:async';

import 'package:coach_finder/common/data/account_type.dart';
import 'package:coach_finder/common/data/secure_storage.dart';
import 'package:coach_finder/features/auth/data/data_sources/remote_auth_data_source.dart';
import 'package:coach_finder/features/auth/data/remote_models/login_payload.dart';
import 'package:coach_finder/features/auth/data/remote_models/login_response.dart';
import 'package:coach_finder/features/auth/data/repository/events.dart';

class AuthRepository {
  final _streamController = StreamController<AuthRepositoryEvents>.broadcast();

  Stream<AuthRepositoryEvents> get eventStream => _streamController.stream;

  final RemoteAuthDataSource _authRemoteDataSource;
  final SecureStorage _secureStorage;

  AuthRepository({
    required RemoteAuthDataSource authRemoteDataSource,
    required SecureStorage secureStorage,
  })  : _secureStorage = secureStorage,
        _authRemoteDataSource = authRemoteDataSource;

  Future<LoginResponse> login({
    required String email,
    required String password,
    required AccountType accountType,
  }) async {
    final LoginResponse loginInfo = await _authRemoteDataSource.login(
      loginPayload: LoginPayload(
        email: email,
        password: password,
        accountType: accountType,
      ),
    );

    if (loginInfo.token != null) {
      _secureStorage.writeSecureData(
        key: SecureStorageKeys.authToken,
        data: loginInfo.token!,
      );

      _streamController.add(const AuthRepositoryEvents.login());
    }

    return loginInfo;
  }

  Future<void> logout({required String email}) async {
    await _authRemoteDataSource.logout(email: email);

    _secureStorage.deleteSecureData(key: SecureStorageKeys.authToken);

    _streamController.add(const AuthRepositoryEvents.logout());
  }

  Future<bool> checkAuth() async {
    return _authRemoteDataSource.checkAuth();
  }
}
