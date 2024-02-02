import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CustomNetworkClient {
  final Dio _dio = Dio();

  Dio get client => _dio;

  CustomNetworkClient() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        request: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = 'http://127.0.0.1:8080';
        },
      ),
    );
  }
}
