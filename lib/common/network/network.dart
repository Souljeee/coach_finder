import 'package:coach_finder/common/data/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CustomNetworkClient {
  final SecureStorage _secureStorage;

  final _authTokenHeader = 'auth-token';
  final Dio _dio = Dio();

  Dio get client => _dio;

  CustomNetworkClient({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        request: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = 'http://127.0.0.1:8080';

          final authToken = await _getAuthToken();

          if(authToken != null){
            options.headers[_authTokenHeader] = authToken;
          }

          handler.next(options);
        },
      ),
    );
  }

  Future<String?> _getAuthToken() async {
    final token =
        await _secureStorage.readSecureData(key: SecureStorageKeys.authToken);

    return token;
  }
}
