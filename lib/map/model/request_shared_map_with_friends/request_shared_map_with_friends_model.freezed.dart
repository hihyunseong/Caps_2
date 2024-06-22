// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_shared_map_with_friends_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestSharedMapWithFriendsModel _$RequestSharedMapWithFriendsModelFromJson(
    Map<String, dynamic> json) {
  return _RequestSharedMapWithFriendsModel.fromJson(json);
}

/// @nodoc
mixin _$RequestSharedMapWithFriendsModel {
  int get mapIdx => throw _privateConstructorUsedError;
  int get memberIdx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestSharedMapWithFriendsModelCopyWith<RequestSharedMapWithFriendsModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestSharedMapWithFriendsModelCopyWith<$Res> {
  factory $RequestSharedMapWithFriendsModelCopyWith(
          RequestSharedMapWithFriendsModel value,
          $Res Function(RequestSharedMapWithFriendsModel) then) =
      _$RequestSharedMapWithFriendsModelCopyWithImpl<$Res,
          RequestSharedMapWithFriendsModel>;
  @useResult
  $Res call({int mapIdx, int memberIdx});
}

/// @nodoc
class _$RequestSharedMapWithFriendsModelCopyWithImpl<$Res,
        $Val extends RequestSharedMapWithFriendsModel>
    implements $RequestSharedMapWithFriendsModelCopyWith<$Res> {
  _$RequestSharedMapWithFriendsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapIdx = null,
    Object? memberIdx = null,
  }) {
    return _then(_value.copyWith(
      mapIdx: null == mapIdx
          ? _value.mapIdx
          : mapIdx // ignore: cast_nullable_to_non_nullable
              as int,
      memberIdx: null == memberIdx
          ? _value.memberIdx
          : memberIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestSharedMapWithFriendsModelImplCopyWith<$Res>
    implements $RequestSharedMapWithFriendsModelCopyWith<$Res> {
  factory _$$RequestSharedMapWithFriendsModelImplCopyWith(
          _$RequestSharedMapWithFriendsModelImpl value,
          $Res Function(_$RequestSharedMapWithFriendsModelImpl) then) =
      __$$RequestSharedMapWithFriendsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int mapIdx, int memberIdx});
}

/// @nodoc
class __$$RequestSharedMapWithFriendsModelImplCopyWithImpl<$Res>
    extends _$RequestSharedMapWithFriendsModelCopyWithImpl<$Res,
        _$RequestSharedMapWithFriendsModelImpl>
    implements _$$RequestSharedMapWithFriendsModelImplCopyWith<$Res> {
  __$$RequestSharedMapWithFriendsModelImplCopyWithImpl(
      _$RequestSharedMapWithFriendsModelImpl _value,
      $Res Function(_$RequestSharedMapWithFriendsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapIdx = null,
    Object? memberIdx = null,
  }) {
    return _then(_$RequestSharedMapWithFriendsModelImpl(
      mapIdx: null == mapIdx
          ? _value.mapIdx
          : mapIdx // ignore: cast_nullable_to_non_nullable
              as int,
      memberIdx: null == memberIdx
          ? _value.memberIdx
          : memberIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestSharedMapWithFriendsModelImpl
    implements _RequestSharedMapWithFriendsModel {
  const _$RequestSharedMapWithFriendsModelImpl(
      {required this.mapIdx, required this.memberIdx});

  factory _$RequestSharedMapWithFriendsModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RequestSharedMapWithFriendsModelImplFromJson(json);

  @override
  final int mapIdx;
  @override
  final int memberIdx;

  @override
  String toString() {
    return 'RequestSharedMapWithFriendsModel(mapIdx: $mapIdx, memberIdx: $memberIdx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestSharedMapWithFriendsModelImpl &&
            (identical(other.mapIdx, mapIdx) || other.mapIdx == mapIdx) &&
            (identical(other.memberIdx, memberIdx) ||
                other.memberIdx == memberIdx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mapIdx, memberIdx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestSharedMapWithFriendsModelImplCopyWith<
          _$RequestSharedMapWithFriendsModelImpl>
      get copyWith => __$$RequestSharedMapWithFriendsModelImplCopyWithImpl<
          _$RequestSharedMapWithFriendsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestSharedMapWithFriendsModelImplToJson(
      this,
    );
  }
}

abstract class _RequestSharedMapWithFriendsModel
    implements RequestSharedMapWithFriendsModel {
  const factory _RequestSharedMapWithFriendsModel(
      {required final int mapIdx,
      required final int memberIdx}) = _$RequestSharedMapWithFriendsModelImpl;

  factory _RequestSharedMapWithFriendsModel.fromJson(
          Map<String, dynamic> json) =
      _$RequestSharedMapWithFriendsModelImpl.fromJson;

  @override
  int get mapIdx;
  @override
  int get memberIdx;
  @override
  @JsonKey(ignore: true)
  _$$RequestSharedMapWithFriendsModelImplCopyWith<
          _$RequestSharedMapWithFriendsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
