// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_friend_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestFriendModel _$RequestFriendModelFromJson(Map<String, dynamic> json) {
  return _RequestFriendModel.fromJson(json);
}

/// @nodoc
mixin _$RequestFriendModel {
  int get friendIdx => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_At')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestFriendModelCopyWith<RequestFriendModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestFriendModelCopyWith<$Res> {
  factory $RequestFriendModelCopyWith(
          RequestFriendModel value, $Res Function(RequestFriendModel) then) =
      _$RequestFriendModelCopyWithImpl<$Res, RequestFriendModel>;
  @useResult
  $Res call(
      {int friendIdx,
      String email,
      String username,
      String? profile,
      @JsonKey(name: 'created_At') DateTime createdAt});
}

/// @nodoc
class _$RequestFriendModelCopyWithImpl<$Res, $Val extends RequestFriendModel>
    implements $RequestFriendModelCopyWith<$Res> {
  _$RequestFriendModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendIdx = null,
    Object? email = null,
    Object? username = null,
    Object? profile = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      friendIdx: null == friendIdx
          ? _value.friendIdx
          : friendIdx // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestFriendModelImplCopyWith<$Res>
    implements $RequestFriendModelCopyWith<$Res> {
  factory _$$RequestFriendModelImplCopyWith(_$RequestFriendModelImpl value,
          $Res Function(_$RequestFriendModelImpl) then) =
      __$$RequestFriendModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int friendIdx,
      String email,
      String username,
      String? profile,
      @JsonKey(name: 'created_At') DateTime createdAt});
}

/// @nodoc
class __$$RequestFriendModelImplCopyWithImpl<$Res>
    extends _$RequestFriendModelCopyWithImpl<$Res, _$RequestFriendModelImpl>
    implements _$$RequestFriendModelImplCopyWith<$Res> {
  __$$RequestFriendModelImplCopyWithImpl(_$RequestFriendModelImpl _value,
      $Res Function(_$RequestFriendModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendIdx = null,
    Object? email = null,
    Object? username = null,
    Object? profile = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$RequestFriendModelImpl(
      friendIdx: null == friendIdx
          ? _value.friendIdx
          : friendIdx // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestFriendModelImpl implements _RequestFriendModel {
  _$RequestFriendModelImpl(
      {required this.friendIdx,
      required this.email,
      required this.username,
      this.profile,
      @JsonKey(name: 'created_At') required this.createdAt});

  factory _$RequestFriendModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestFriendModelImplFromJson(json);

  @override
  final int friendIdx;
  @override
  final String email;
  @override
  final String username;
  @override
  final String? profile;
  @override
  @JsonKey(name: 'created_At')
  final DateTime createdAt;

  @override
  String toString() {
    return 'RequestFriendModel(friendIdx: $friendIdx, email: $email, username: $username, profile: $profile, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestFriendModelImpl &&
            (identical(other.friendIdx, friendIdx) ||
                other.friendIdx == friendIdx) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, friendIdx, email, username, profile, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestFriendModelImplCopyWith<_$RequestFriendModelImpl> get copyWith =>
      __$$RequestFriendModelImplCopyWithImpl<_$RequestFriendModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestFriendModelImplToJson(
      this,
    );
  }
}

abstract class _RequestFriendModel implements RequestFriendModel {
  factory _RequestFriendModel(
          {required final int friendIdx,
          required final String email,
          required final String username,
          final String? profile,
          @JsonKey(name: 'created_At') required final DateTime createdAt}) =
      _$RequestFriendModelImpl;

  factory _RequestFriendModel.fromJson(Map<String, dynamic> json) =
      _$RequestFriendModelImpl.fromJson;

  @override
  int get friendIdx;
  @override
  String get email;
  @override
  String get username;
  @override
  String? get profile;
  @override
  @JsonKey(name: 'created_At')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$RequestFriendModelImplCopyWith<_$RequestFriendModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
