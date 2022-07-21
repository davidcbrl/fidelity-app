import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioProvider {
  String baseUrl = '';
  Dio _dio = Dio();
  GetStorage box = GetStorage();
  bool isDanilo = false;

  DioProvider({required String baseUrl}) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    _setupInterceptor();
  }

  Future<dynamic> get(String path) async {
    return _dio.get(path);
  }

  Future<dynamic> put(String path, dynamic data) async {
    return _dio.put(path, data: data);
  }

  Future<dynamic> post(String path, dynamic data) async {
    return _dio.post(path, data: data);
  }

  Future<dynamic> delete(String path) async {
    return _dio.delete(path);
  }

  void _setupInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}');
      if (options.method.contains('P')) {
        print('REQUEST[${options.method}] => PAYLOAD: ${options.data}');
      }
      if (box.hasData('jwt')) {
        options.headers['Authorization'] = 'Bearer ${box.read('jwt')}';
        print('REQUEST[${options.method}] => TOKEN: ${box.read('jwt')}');
      }
      if (options.baseUrl.contains('onesignal')) {
        options.headers['Authorization'] = 'Basic ZDFkYTg5YTMtODhhMS00OWI0LTg2YTctNTJjOGUxZmQ5OTNm';
        print('REQUEST[${options.method}] => TOKEN: ${box.read('jwt')}');
      }
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
