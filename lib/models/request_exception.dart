import 'package:get/get.dart';

class RequestException implements Exception {
  final String? message;
  final String? statusCode;
  final Response? response;

  RequestException({
    this.message,
    this.statusCode,
    this.response,
  });

  @override
  String toString() => 'BaseException(message: $message, statusCode: $statusCode)';
}