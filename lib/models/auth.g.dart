// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AuthRequest> _$authRequestSerializer = new _$AuthRequestSerializer();

class _$AuthRequestSerializer implements StructuredSerializer<AuthRequest> {
  @override
  final Iterable<Type> types = const [AuthRequest, _$AuthRequest];
  @override
  final String wireName = 'AuthRequest';

  @override
  Iterable<Object?> serialize(Serializers serializers, AuthRequest object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AuthRequest deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthRequestBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$AuthRequest extends AuthRequest {
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? type;

  factory _$AuthRequest([void Function(AuthRequestBuilder)? updates]) =>
      (new AuthRequestBuilder()..update(updates)).build();

  _$AuthRequest._({this.email, this.password, this.type}) : super._();

  @override
  AuthRequest rebuild(void Function(AuthRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthRequestBuilder toBuilder() => new AuthRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthRequest &&
        email == other.email &&
        password == other.password &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, email.hashCode), password.hashCode), type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('type', type))
        .toString();
  }
}

class AuthRequestBuilder implements Builder<AuthRequest, AuthRequestBuilder> {
  _$AuthRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  AuthRequestBuilder();

  AuthRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AuthRequest;
  }

  @override
  void update(void Function(AuthRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthRequest build() {
    final _$result = _$v ??
        new _$AuthRequest._(email: email, password: password, type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
