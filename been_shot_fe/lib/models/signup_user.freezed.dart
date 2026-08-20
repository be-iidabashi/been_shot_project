// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SignupUser _$SignupUserFromJson(Map<String, dynamic> json) {
  return _SignupUser.fromJson(json);
}

/// @nodoc
mixin _$SignupUser {
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this SignupUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignupUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupUserCopyWith<SignupUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupUserCopyWith<$Res> {
  factory $SignupUserCopyWith(
    SignupUser value,
    $Res Function(SignupUser) then,
  ) = _$SignupUserCopyWithImpl<$Res, SignupUser>;
  @useResult
  $Res call({String username, String email, String password});
}

/// @nodoc
class _$SignupUserCopyWithImpl<$Res, $Val extends SignupUser>
    implements $SignupUserCopyWith<$Res> {
  _$SignupUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(
      _value.copyWith(
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignupUserImplCopyWith<$Res>
    implements $SignupUserCopyWith<$Res> {
  factory _$$SignupUserImplCopyWith(
    _$SignupUserImpl value,
    $Res Function(_$SignupUserImpl) then,
  ) = __$$SignupUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String email, String password});
}

/// @nodoc
class __$$SignupUserImplCopyWithImpl<$Res>
    extends _$SignupUserCopyWithImpl<$Res, _$SignupUserImpl>
    implements _$$SignupUserImplCopyWith<$Res> {
  __$$SignupUserImplCopyWithImpl(
    _$SignupUserImpl _value,
    $Res Function(_$SignupUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignupUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(
      _$SignupUserImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupUserImpl with DiagnosticableTreeMixin implements _SignupUser {
  const _$SignupUserImpl({
    required this.username,
    required this.email,
    required this.password,
  });

  factory _$SignupUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupUserImplFromJson(json);

  @override
  final String username;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupUser(username: $username, email: $email, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignupUser'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupUserImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, email, password);

  /// Create a copy of SignupUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupUserImplCopyWith<_$SignupUserImpl> get copyWith =>
      __$$SignupUserImplCopyWithImpl<_$SignupUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupUserImplToJson(this);
  }
}

abstract class _SignupUser implements SignupUser {
  const factory _SignupUser({
    required final String username,
    required final String email,
    required final String password,
  }) = _$SignupUserImpl;

  factory _SignupUser.fromJson(Map<String, dynamic> json) =
      _$SignupUserImpl.fromJson;

  @override
  String get username;
  @override
  String get email;
  @override
  String get password;

  /// Create a copy of SignupUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupUserImplCopyWith<_$SignupUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
