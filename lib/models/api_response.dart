
import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'api_response.g.dart';

abstract class ApiResponse implements Built<ApiResponse, ApiResponseBuilder> {
  @BuiltValueField(wireName: 'Success')
  bool get success;
  @BuiltValueField(wireName: 'Message')
  String get message;
  @BuiltValueField(wireName: 'Count')
  int get count;
  @BuiltValueField(wireName: 'Result')
  Object? get result;

  ApiResponse._();

  factory ApiResponse([updates(ApiResponseBuilder b)]) = _$ApiResponse;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(ApiResponse.serializer, this));
  }

  static ApiResponse? fromJson(Object serialized) {
    return standardSerializers.deserializeWith(ApiResponse.serializer, serialized);
  }

  static Serializer<ApiResponse> get serializer => _$apiResponseSerializer;
}
