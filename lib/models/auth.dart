import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'auth.g.dart';

abstract class AuthRequest implements Built<AuthRequest, AuthRequestBuilder> {
  String? get email;
  String? get password;
  String? get type;

  AuthRequest._();

  factory AuthRequest([updates(AuthRequestBuilder b)]) = _$AuthRequest;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(AuthRequest.serializer, this));
  }

  static AuthRequest? fromJson(Object serialized) {
    return standardSerializers.deserializeWith(AuthRequest.serializer, serialized);
  }

  static Serializer<AuthRequest> get serializer => _$authRequestSerializer;
}
