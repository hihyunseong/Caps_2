// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_map_title_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestMapTitleModel _$RequestMapTitleModelFromJson(Map<String, dynamic> json) {
  return _RequestMapTitleModel.fromJson(json);
}

/// @nodoc
mixin _$RequestMapTitleModel {
  String get title => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  String get selectedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestMapTitleModelCopyWith<RequestMapTitleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestMapTitleModelCopyWith<$Res> {
  factory $RequestMapTitleModelCopyWith(RequestMapTitleModel value,
          $Res Function(RequestMapTitleModel) then) =
      _$RequestMapTitleModelCopyWithImpl<$Res, RequestMapTitleModel>;
  @useResult
  $Res call(
      {String title,
      String color,
      double lat,
      double lon,
      String selectedDate});
}

/// @nodoc
class _$RequestMapTitleModelCopyWithImpl<$Res,
        $Val extends RequestMapTitleModel>
    implements $RequestMapTitleModelCopyWith<$Res> {
  _$RequestMapTitleModelCopyWithImpl(this._value, this._then);

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
abstract class _$$RequestMapTitleModelImplCopyWith<$Res>
    implements $RequestMapTitleModelCopyWith<$Res> {
  factory _$$RequestMapTitleModelImplCopyWith(_$RequestMapTitleModelImpl value,
          $Res Function(_$RequestMapTitleModelImpl) then) =
      __$$RequestMapTitleModelImplCopyWithImpl<$Res>;
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
class __$$RequestMapTitleModelImplCopyWithImpl<$Res>
    extends _$RequestMapTitleModelCopyWithImpl<$Res, _$RequestMapTitleModelImpl>
    implements _$$RequestMapTitleModelImplCopyWith<$Res> {
  __$$RequestMapTitleModelImplCopyWithImpl(_$RequestMapTitleModelImpl _value,
      $Res Function(_$RequestMapTitleModelImpl) _then)
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
    return _then(_$RequestMapTitleModelImpl(
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
class _$RequestMapTitleModelImpl implements _RequestMapTitleModel {
  const _$RequestMapTitleModelImpl(
      {required this.title,
      required this.color,
      required this.lat,
      required this.lon,
      required this.selectedDate});

  factory _$RequestMapTitleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestMapTitleModelImplFromJson(json);

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
    return 'RequestMapTitleModel(title: $title, color: $color, lat: $lat, lon: $lon, selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestMapTitleModelImpl &&
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
  _$$RequestMapTitleModelImplCopyWith<_$RequestMapTitleModelImpl>
      get copyWith =>
          __$$RequestMapTitleModelImplCopyWithImpl<_$RequestMapTitleModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestMapTitleModelImplToJson(
      this,
    );
  }
}

abstract class _RequestMapTitleModel implements RequestMapTitleModel {
  const factory _RequestMapTitleModel(
      {required final String title,
       required final String color,
      required final double lat,
      required final double lon,
      required final String selectedDate}) = _$RequestMapTitleModelImpl;

  factory _RequestMapTitleModel.fromJson(Map<String, dynamic> json) =
      _$RequestMapTitleModelImpl.fromJson;

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
  _$$RequestMapTitleModelImplCopyWith<_$RequestMapTitleModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
