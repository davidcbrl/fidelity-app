import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioProvider {
  Dio _dio = Dio();
  GetStorage box = GetStorage();
  bool isDanilo = true;

  DioProvider() {
    _dio.options = BaseOptions(
      baseUrl: isDanilo ? 'https://fidelity.conveyor.cloud/' : 'https://fidelity-kp0.conveyor.cloud/',
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
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (box.hasData('jwt')) {
        options.headers['Authorization'] = 'Bearer ${box.read('jwt')}';
      }
      print('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}');
      if (options.method == 'POST') print('REQUEST[${options.method}] => PAYLOAD: ${options.data}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}]');
      return handler.next(response);
    }, onError: (DioError error, handler) {
      print('ERROR\n[\n$error]');
      return handler.next(error);
    }));
  }
}
