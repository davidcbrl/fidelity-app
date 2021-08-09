import 'package:dio/dio.dart';

class DioProvider {
  Dio _dio = Dio();

  DioProvider() {
    _dio.options = BaseOptions(
      baseUrl: 'https://fidelity.conveyor.cloud/',
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    _setupInterceptor();
  }

  Future<dynamic> get(String path) async {
    return _dio.get(path);
  }

  Future<dynamic> post(String path, dynamic data) async {
    return _dio.post(path, data: data);
  }

  Future<dynamic> delete(String path) async {
    return _dio.delete(path);
  }

  void _setupInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:(options, handler){
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          if (options.method == 'POST') print('REQUEST[${options.method}] => PAYLOAD: ${options.data}');
          return handler.next(options);
        },
        onResponse:(response, handler) {
          print('RESPONSE[${response.statusCode}]');
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          print('ERROR\n[\n$error]');
          return handler.next(error);
        }
      )
    );
  }
}