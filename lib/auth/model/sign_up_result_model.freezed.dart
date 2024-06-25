// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignUpResultModel _$SignUpResultModelFromJson(Map<String, dynamic> json) {
  return _SignUpResultModel.fromJson(json);
}

/// @nodoc
mixin _$SignUpResultModel {
  int get idx => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get profile => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpResultModelCopyWith<SignUpResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpResultModelCopyWith<$Res> {
  factory $SignUpResultModelCopyWith(
          SignUpResultModel value, $Res Function(SignUpResultModel) then) =
      _$SignUpResultModelCopyWithImpl<$Res, SignUpResultModel>;
  @useResult
  $Res call(
      {int idx,
      String email,
      String name,
      String profile,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$SignUpResultModelCopyWithImpl<$Res, $Val extends SignUpResultModel>
    implements $SignUpResultModelCopyWith<$Res> {
  _$SignUpResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? email = null,
    Object? name = null,
    Object? profile = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpResultModelImplCopyWith<$Res>
    implements $SignUpResultModelCopyWith<$Res> {
  factory _$$SignUpResultModelImplCopyWith(_$SignUpResultModelImpl value,
          $Res Function(_$SignUpResultModelImpl) then) =
      __$$SignUpResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int idx,
      String email,
      String name,
      String profile,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$SignUpResultModelImplCopyWithImpl<$Res>
    extends _$SignUpResultModelCopyWithImpl<$Res, _$SignUpResultModelImpl>
    implements _$$SignUpResultModelImplCopyWith<$Res> {
  __$$SignUpResultModelImplCopyWithImpl(_$SignUpResultModelImpl _value,
      $Res Function(_$SignUpResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idx = null,
    Object? email = null,
    Object? name = null,
    Object? profile = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SignUpResultModelImpl(
      idx: null == idx
          ? _value.idx
          : idx // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpResultModelImpl implements _SignUpResultModel {
  _$SignUpResultModelImpl(
      {required this.idx,
      required this.email,
      required this.name,
      required this.profile,
      required this.createdAt,
      required this.updatedAt});

  factory _$SignUpResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpResultModelImplFromJson(json);

  @override
  final int idx;
  @override
  final String email;
  @override
  final String name;
  @override
  final String profile;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SignUpResultModel(idx: $idx, email: $email, name: $name, profile: $profile, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpResultModelImpl &&
            (identical(other.idx, idx) || other.idx == idx) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idx, email, name, profile, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpResultModelImplCopyWith<_$SignUpResultModelImpl> get copyWith =>
      __$$SignUpResultModelImplCopyWithImpl<_$SignUpResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpResultModelImplToJson(
      this,
    );
  }
}

abstract class _SignUpResultModel implements SignUpResultModel {
  factory _SignUpResultModel(
      {required final int idx,
      required final String email,
      required final String name,
      required final String profile,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$SignUpResultModelImpl;

  factory _SignUpResultModel.fromJson(Map<String, dynamic> json) =
      _$SignUpResultModelImpl.fromJson;

  @override
  int get idx;
  @override
  String get email;
  @override
  String get name;
  @override
  String get profile;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SignUpResultModelImplCopyWith<_$SignUpResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
