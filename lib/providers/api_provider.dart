import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fidelity/models/request_exception.dart';
import 'package:fidelity/providers/dio_provider.dart';

class ApiProvider {

  static Future get({required String path}) async {
    try {
      Response response = await DioProvider().get(path);
      return jsonDecode(response.data);
    } on DioError catch (error) {
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

  static Future post({required String path, dynamic data}) async {
    try {
      Response response = await DioProvider().post(path, data);
      return jsonDecode(response.data);
    } on DioError catch (error) {
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
      Response response = await DioProvider().delete(path);
      return response;
    } on DioError catch (error) {
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