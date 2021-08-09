// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApiResponse> _$apiResponseSerializer = new _$ApiResponseSerializer();

class _$ApiResponseSerializer implements StructuredSerializer<ApiResponse> {
  @override
  final Iterable<Type> types = const [ApiResponse, _$ApiResponse];
  @override
  final String wireName = 'ApiResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, ApiResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'Success',
      serializers.serialize(object.success,
          specifiedType: const FullType(bool)),
      'Message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'Count',
      serializers.serialize(object.count, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ApiResponse deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApiResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'Message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Count':
          result.count = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ApiResponse extends ApiResponse {
  @override
  final bool success;
  @override
  final String message;
  @override
  final int count;

  factory _$ApiResponse([void Function(ApiResponseBuilder)? updates]) =>
      (new ApiResponseBuilder()..update(updates)).build();

  _$ApiResponse._(
      {required this.success, required this.message, required this.count})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(success, 'ApiResponse', 'success');
    BuiltValueNullFieldError.checkNotNull(message, 'ApiResponse', 'message');
    BuiltValueNullFieldError.checkNotNull(count, 'ApiResponse', 'count');
  }

  @override
  ApiResponse rebuild(void Function(ApiResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiResponseBuilder toBuilder() => new ApiResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiResponse &&
        success == other.success &&
        message == other.message &&
        count == other.count;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, success.hashCode), message.hashCode), count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApiResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('count', count))
        .toString();
  }
}

class ApiResponseBuilder implements Builder<ApiResponse, ApiResponseBuilder> {
  _$ApiResponse? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  ApiResponseBuilder();

  ApiResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ApiResponse;
  }

  @override
  void update(void Function(ApiResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApiResponse build() {
    final _$result = _$v ??
        new _$ApiResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, 'ApiResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, 'ApiResponse', 'message'),
            count: BuiltValueNullFieldError.checkNotNull(
                count, 'ApiResponse', 'count'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
