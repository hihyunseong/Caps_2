// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_pin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestPinModel _$RequestPinModelFromJson(Map<String, dynamic> json) {
  return _RequestPinModel.fromJson(json);
}

/// @nodoc
mixin _$RequestPinModel {
  DtoModel get dto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestPinModelCopyWith<RequestPinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestPinModelCopyWith<$Res> {
  factory $RequestPinModelCopyWith(
          RequestPinModel value, $Res Function(RequestPinModel) then) =
      _$RequestPinModelCopyWithImpl<$Res, RequestPinModel>;
  @useResult
  $Res call({DtoModel dto});

  $DtoModelCopyWith<$Res> get dto;
}

/// @nodoc
class _$RequestPinModelCopyWithImpl<$Res, $Val extends RequestPinModel>
    implements $RequestPinModelCopyWith<$Res> {
  _$RequestPinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dto = null,
  }) {
    return _then(_value.copyWith(
      dto: null == dto
          ? _value.dto
          : dto // ignore: cast_nullable_to_non_nullable
              as DtoModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DtoModelCopyWith<$Res> get dto {
    return $DtoModelCopyWith<$Res>(_value.dto, (value) {
      return _then(_value.copyWith(dto: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RequestPinModelImplCopyWith<$Res>
    implements $RequestPinModelCopyWith<$Res> {
  factory _$$RequestPinModelImplCopyWith(_$RequestPinModelImpl value,
          $Res Function(_$RequestPinModelImpl) then) =
      __$$RequestPinModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DtoModel dto});

  @override
  $DtoModelCopyWith<$Res> get dto;
}

/// @nodoc
class __$$RequestPinModelImplCopyWithImpl<$Res>
    extends _$RequestPinModelCopyWithImpl<$Res, _$RequestPinModelImpl>
    implements _$$RequestPinModelImplCopyWith<$Res> {
  __$$RequestPinModelImplCopyWithImpl(
      _$RequestPinModelImpl _value, $Res Function(_$RequestPinModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dto = null,
  }) {
    return _then(_$RequestPinModelImpl(
      dto: null == dto
          ? _value.dto
          : dto // ignore: cast_nullable_to_non_nullable
              as DtoModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestPinModelImpl implements _RequestPinModel {
  const _$RequestPinModelImpl({required this.dto});

  factory _$RequestPinModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestPinModelImplFromJson(json);

  @override
  final DtoModel dto;

  @override
  String toString() {
    return 'RequestPinModel(dto: $dto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestPinModelImpl &&
            (identical(other.dto, dto) || other.dto == dto));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dto);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestPinModelImplCopyWith<_$RequestPinModelImpl> get copyWith =>
      __$$RequestPinModelImplCopyWithImpl<_$RequestPinModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestPinModelImplToJson(
      this,
    );
  }
}

abstract class _RequestPinModel implements RequestPinModel {
  const factory _RequestPinModel({required final DtoModel dto}) =
      _$RequestPinModelImpl;

  factory _RequestPinModel.fromJson(Map<String, dynamic> json) =
      _$RequestPinModelImpl.fromJson;

  @override
  DtoModel get dto;
  @override
  @JsonKey(ignore: true)
  _$$RequestPinModelImplCopyWith<_$RequestPinModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
