import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  int? get id;
  String? get name;

  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  String toJson() {
    return json.encode(standardSerializers.serializeWith(User.serializer, this));
  }

  static User? fromJson(Object serialized) {
    return standardSerializers.deserializeWith(User.serializer, serialized);
  }

  static Serializer<User> get serializer => _$userSerializer;
}
