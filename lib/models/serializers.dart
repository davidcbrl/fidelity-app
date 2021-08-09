library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:fidelity/models/auth.dart';
import 'package:fidelity/models/user.dart';

import 'api_response.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  ApiResponse,
  AuthRequest,
  User,
])
final Serializers serializers = _$serializers;

final standardSerializers = (serializers.toBuilder()..addPlugin(new StandardJsonPlugin())).build();
