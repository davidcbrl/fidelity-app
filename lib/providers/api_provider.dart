import 'package:dio/dio.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/dio_provider.dart';

class ApiProvider {
  static const baseUrl = 'http://fidelityapp.azurewebsites.net/';

  static Future get({required String path}) async {
    try {
      Response response = await DioProvider(baseUrl: baseUrl).get(path);
      return response.data;
    } on DioException catch (error) {
      print(error.response);
      var errorMessage = error.response?.data['Message'] != null ? error.response?.data['Message'] : error.error;
      return throw RequestException(
        message: errorMessage,
        statusCode: '',
      );
    } catch (error) {
      return throw RequestException(
        message: error.toString(),
        statusCode: '',
      );
    }
  }

  static Future put({required String path, dynamic data}) async {
    try {
      Response response = await DioProvider(baseUrl: baseUrl).put(path, data);
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

  static Future delete({required String path}) async {
    try {
      Response response = await DioProvider(baseUrl: baseUrl).delete(path);
      return response;
    } on DioException catch (error) {
      print(error.response);
      return throw RequestException(
        message: 'Request error',
        statusCode: '',
      );
    } catch (error) {
      return throw RequestException(
        message: error.toString(),
        statusCode: '',
      );
    }
  }

}