// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_shared_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestSharedMapModel _$RequestSharedMapModelFromJson(
    Map<String, dynamic> json) {
  return _RequestSharedMapModel.fromJson(json);
}

/// @nodoc
mixin _$RequestSharedMapModel {
  String get title => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String get selectedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestSharedMapModelCopyWith<RequestSharedMapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestSharedMapModelCopyWith<$Res> {
  factory $RequestSharedMapModelCopyWith(RequestSharedMapModel value,
          $Res Function(RequestSharedMapModel) then) =
      _$RequestSharedMapModelCopyWithImpl<$Res, RequestSharedMapModel>;
  @useResult
  $Res call(
      {String title,
      String color,
      double lat,
      double lon,
      String selectedDate});
}

/// @nodoc
class _$RequestSharedMapModelCopyWithImpl<$Res,
        $Val extends RequestSharedMapModel>
    implements $RequestSharedMapModelCopyWith<$Res> {
  _$RequestSharedMapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? color = null,
    Object? lat = null,
    Object? lon = null,
    Object? selectedDate = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestSharedMapModelImplCopyWith<$Res>
    implements $RequestSharedMapModelCopyWith<$Res> {
  factory _$$RequestSharedMapModelImplCopyWith(
          _$RequestSharedMapModelImpl value,
          $Res Function(_$RequestSharedMapModelImpl) then) =
      __$$RequestSharedMapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String color,
      double lat,
      double lon,
      String selectedDate});
}

/// @nodoc
class __$$RequestSharedMapModelImplCopyWithImpl<$Res>
    extends _$RequestSharedMapModelCopyWithImpl<$Res,
        _$RequestSharedMapModelImpl>
    implements _$$RequestSharedMapModelImplCopyWith<$Res> {
  __$$RequestSharedMapModelImplCopyWithImpl(_$RequestSharedMapModelImpl _value,
      $Res Function(_$RequestSharedMapModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? color = null,
    Object? lat = null,
    Object? lon = null,
    Object? selectedDate = null,
  }) {
    return _then(_$RequestSharedMapModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestSharedMapModelImpl implements _RequestSharedMapModel {
  const _$RequestSharedMapModelImpl(
      {required this.title,
      required this.color,
      required this.lat,
      required this.lon,
      required this.selectedDate});

  factory _$RequestSharedMapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestSharedMapModelImplFromJson(json);

  @override
  final String title;
  @override
  final String color;
  @override
  final double lat;
  @override
  final double lon;
  @override
  final String selectedDate;

  @override
  String toString() {
    return 'RequestSharedMapModel(title: $title, color: $color, lat: $lat, lon: $lon, selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestSharedMapModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, color, lat, lon, selectedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestSharedMapModelImplCopyWith<_$RequestSharedMapModelImpl>
      get copyWith => __$$RequestSharedMapModelImplCopyWithImpl<
          _$RequestSharedMapModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestSharedMapModelImplToJson(
      this,
    );
  }
}

abstract class _RequestSharedMapModel implements RequestSharedMapModel {
  const factory _RequestSharedMapModel(
      {required final String title,
      required final String color,
      required final double lat,
      required final double lon,
      required final String selectedDate}) = _$RequestSharedMapModelImpl;

  factory _RequestSharedMapModel.fromJson(Map<String, dynamic> json) =
      _$RequestSharedMapModelImpl.fromJson;

  @override
  String get title;
  @override
  String get color;
  @override
  double get lat;
  @override
  double get lon;
  @override
  String get selectedDate;
  @override
  @JsonKey(ignore: true)
  _$$RequestSharedMapModelImplCopyWith<_$RequestSharedMapModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
