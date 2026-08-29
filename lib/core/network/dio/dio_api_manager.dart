import 'package:dio/dio.dart';
import '../../helpers/secure_storage_helper.dart';

class DioApiManager {
  static final DioApiManager _instance = DioApiManager._internal();

  factory DioApiManager() => _instance;

  DioApiManager._internal() {
    _initInterceptors();
  }

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://soor.sys-web.net/api/v1',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  void _initInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getToken();
          final tokenType =
              await SecureStorageHelper.getTokenType() ?? 'Bearer';
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = '$tokenType $token';
          }
          options.headers['lang'] ??= 'ar';
          return handler.next(options);
        },
        onError: (e, handler) => handler.next(e),
      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }
}
