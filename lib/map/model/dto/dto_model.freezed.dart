// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dto_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DtoModel _$DtoModelFromJson(Map<String, dynamic> json) {
  return _DtoModel.fromJson(json);
}

/// @nodoc
mixin _$DtoModel {
  String get place => throw _privateConstructorUsedError;
  String get header => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  int get cost => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lon => throw _privateConstructorUsedError;
  List<int> get list => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DtoModelCopyWith<DtoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DtoModelCopyWith<$Res> {
  factory $DtoModelCopyWith(DtoModel value, $Res Function(DtoModel) then) =
      _$DtoModelCopyWithImpl<$Res, DtoModel>;
  @useResult
  $Res call(
      {String place,
      String header,
      String title,
      String method,
      String category,
      String memo,
      int cost,
      double lat,
      double lon,
      List<int> list});
}

/// @nodoc
class _$DtoModelCopyWithImpl<$Res, $Val extends DtoModel>
    implements $DtoModelCopyWith<$Res> {
  _$DtoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? place = null,
    Object? header = null,
    Object? title = null,
    Object? method = null,
    Object? category = null,
    Object? memo = null,
    Object? cost = null,
    Object? lat = null,
    Object? lon = null,
    Object? list = null,
  }) {
    return _then(_value.copyWith(
      place: null == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String,
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DtoModelImplCopyWith<$Res>
    implements $DtoModelCopyWith<$Res> {
  factory _$$DtoModelImplCopyWith(
          _$DtoModelImpl value, $Res Function(_$DtoModelImpl) then) =
      __$$DtoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String place,
      String header,
      String title,
      String method,
      String category,
      String memo,
      int cost,
      double lat,
      double lon,
      List<int> list});
}

/// @nodoc
class __$$DtoModelImplCopyWithImpl<$Res>
    extends _$DtoModelCopyWithImpl<$Res, _$DtoModelImpl>
    implements _$$DtoModelImplCopyWith<$Res> {
  __$$DtoModelImplCopyWithImpl(
      _$DtoModelImpl _value, $Res Function(_$DtoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? place = null,
    Object? header = null,
    Object? title = null,
    Object? method = null,
    Object? category = null,
    Object? memo = null,
    Object? cost = null,
    Object? lat = null,
    Object? lon = null,
    Object? list = null,
  }) {
    return _then(_$DtoModelImpl(
      place: null == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String,
      header: null == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as int,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lon: null == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DtoModelImpl implements _DtoModel {
  const _$DtoModelImpl(
      {required this.place,
      required this.header,
      required this.title,
      required this.method,
      required this.category,
      required this.memo,
      required this.cost,
      required this.lat,
      required this.lon,
      required final List<int> list})
      : _list = list;

  factory _$DtoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DtoModelImplFromJson(json);

  @override
  final String place;
  @override
  final String header;
  @override
  final String title;
  @override
  final String method;
  @override
  final String category;
  @override
  final String memo;
  @override
  final int cost;
  @override
  final double lat;
  @override
  final double lon;
  final List<int> _list;
  @override
  List<int> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'DtoModel(place: $place, header: $header, title: $title, method: $method, category: $category, memo: $memo, cost: $cost, lat: $lat, lon: $lon, list: $list)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DtoModelImpl &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      place,
      header,
      title,
      method,
      category,
      memo,
      cost,
      lat,
      lon,
      const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DtoModelImplCopyWith<_$DtoModelImpl> get copyWith =>
      __$$DtoModelImplCopyWithImpl<_$DtoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DtoModelImplToJson(
      this,
    );
  }
}

abstract class _DtoModel implements DtoModel {
  const factory _DtoModel(
      {required final String place,
      required final String header,
      required final String title,
      required final String method,
      required final String category,
      required final String memo,
      required final int cost,
      required final double lat,
      required final double lon,
      required final List<int> list}) = _$DtoModelImpl;

  factory _DtoModel.fromJson(Map<String, dynamic> json) =
      _$DtoModelImpl.fromJson;

  @override
  String get place;
  @override
  String get header;
  @override
  String get title;
  @override
  String get method;
  @override
  String get category;
  @override
  String get memo;
  @override
  int get cost;
  @override
  double get lat;
  @override
  double get lon;
  @override
  List<int> get list;
  @override
  @JsonKey(ignore: true)
  _$$DtoModelImplCopyWith<_$DtoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
