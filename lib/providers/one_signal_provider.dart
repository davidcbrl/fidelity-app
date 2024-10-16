import 'package:dio/dio.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/dio_provider.dart';

class OneSignalProvider {
  static const baseUrl = 'https://onesignal.com/api/v1/';

  static Future post({required String path, dynamic data}) async {
    try {
      Response response = await DioProvider(baseUrl: baseUrl).post(path, data);
      return response.data;
    } on DioException catch (error) {
      print(error.response);
      return throw RequestException(
        message: 'Request error',
      );
    } catch (error) {
      return throw RequestException(
        message: error.toString(),
      );
    }
  }
}
