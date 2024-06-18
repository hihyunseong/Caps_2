// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapModel _$MapModelFromJson(Map<String, dynamic> json) {
  return _MapModel.fromJson(json);
}

/// @nodoc
mixin _$MapModel {
  String get mapName => throw _privateConstructorUsedError;
  int get ownerId => throw _privateConstructorUsedError;
  List<FriendModel> get friends => throw _privateConstructorUsedError;
  Prediction get location => throw _privateConstructorUsedError;
  DateTime get selectedDate => throw _privateConstructorUsedError;
  List<Expense> get expenses => throw _privateConstructorUsedError;
  bool get isSharedMap => throw _privateConstructorUsedError;
  DateTime? get lastExpensesUpdate => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapModelCopyWith<MapModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapModelCopyWith<$Res> {
  factory $MapModelCopyWith(MapModel value, $Res Function(MapModel) then) =
      _$MapModelCopyWithImpl<$Res, MapModel>;
  @useResult
  $Res call(
      {String mapName,
      int ownerId,
      List<FriendModel> friends,
      Prediction location,
      DateTime selectedDate,
      List<Expense> expenses,
      bool isSharedMap,
      DateTime? lastExpensesUpdate,
      @ColorConverter() Color color});
}

/// @nodoc
class _$MapModelCopyWithImpl<$Res, $Val extends MapModel>
    implements $MapModelCopyWith<$Res> {
  _$MapModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapName = null,
    Object? ownerId = null,
    Object? friends = null,
    Object? location = null,
    Object? selectedDate = null,
    Object? expenses = null,
    Object? isSharedMap = null,
    Object? lastExpensesUpdate = freezed,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      mapName: null == mapName
          ? _value.mapName
          : mapName // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<FriendModel>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Prediction,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
      isSharedMap: null == isSharedMap
          ? _value.isSharedMap
          : isSharedMap // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExpensesUpdate: freezed == lastExpensesUpdate
          ? _value.lastExpensesUpdate
          : lastExpensesUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapModelImplCopyWith<$Res>
    implements $MapModelCopyWith<$Res> {
  factory _$$MapModelImplCopyWith(
          _$MapModelImpl value, $Res Function(_$MapModelImpl) then) =
      __$$MapModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String mapName,
      int ownerId,
      List<FriendModel> friends,
      Prediction location,
      DateTime selectedDate,
      List<Expense> expenses,
      bool isSharedMap,
      DateTime? lastExpensesUpdate,
      @ColorConverter() Color color});
}

/// @nodoc
class __$$MapModelImplCopyWithImpl<$Res>
    extends _$MapModelCopyWithImpl<$Res, _$MapModelImpl>
    implements _$$MapModelImplCopyWith<$Res> {
  __$$MapModelImplCopyWithImpl(
      _$MapModelImpl _value, $Res Function(_$MapModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapName = null,
    Object? ownerId = null,
    Object? friends = null,
    Object? location = null,
    Object? selectedDate = null,
    Object? expenses = null,
    Object? isSharedMap = null,
    Object? lastExpensesUpdate = freezed,
    Object? color = null,
  }) {
    return _then(_$MapModelImpl(
      mapName: null == mapName
          ? _value.mapName
          : mapName // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<FriendModel>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Prediction,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
      isSharedMap: null == isSharedMap
          ? _value.isSharedMap
          : isSharedMap // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExpensesUpdate: freezed == lastExpensesUpdate
          ? _value.lastExpensesUpdate
          : lastExpensesUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapModelImpl extends _MapModel {
  _$MapModelImpl(
      {required this.mapName,
      required this.ownerId,
      required final List<FriendModel> friends,
      required this.location,
      required this.selectedDate,
      required final List<Expense> expenses,
      required this.isSharedMap,
      this.lastExpensesUpdate,
      @ColorConverter() required this.color})
      : _friends = friends,
        _expenses = expenses,
        super._();

  factory _$MapModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapModelImplFromJson(json);

  @override
  final String mapName;
  @override
  final int ownerId;
  final List<FriendModel> _friends;
  @override
  List<FriendModel> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  @override
  final Prediction location;
  @override
  final DateTime selectedDate;
  final List<Expense> _expenses;
  @override
  List<Expense> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  final bool isSharedMap;
  @override
  final DateTime? lastExpensesUpdate;
  @override
  @ColorConverter()
  final Color color;

  @override
  String toString() {
    return 'MapModel(mapName: $mapName, ownerId: $ownerId, friends: $friends, location: $location, selectedDate: $selectedDate, expenses: $expenses, isSharedMap: $isSharedMap, lastExpensesUpdate: $lastExpensesUpdate, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapModelImpl &&
            (identical(other.mapName, mapName) || other.mapName == mapName) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            (identical(other.isSharedMap, isSharedMap) ||
                other.isSharedMap == isSharedMap) &&
            (identical(other.lastExpensesUpdate, lastExpensesUpdate) ||
                other.lastExpensesUpdate == lastExpensesUpdate) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mapName,
      ownerId,
      const DeepCollectionEquality().hash(_friends),
      location,
      selectedDate,
      const DeepCollectionEquality().hash(_expenses),
      isSharedMap,
      lastExpensesUpdate,
      color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapModelImplCopyWith<_$MapModelImpl> get copyWith =>
      __$$MapModelImplCopyWithImpl<_$MapModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapModelImplToJson(
      this,
    );
  }
}

abstract class _MapModel extends MapModel {
  factory _MapModel(
      {required final String mapName,
      required final int ownerId,
      required final List<FriendModel> friends,
      required final Prediction location,
      required final DateTime selectedDate,
      required final List<Expense> expenses,
      required final bool isSharedMap,
      final DateTime? lastExpensesUpdate,
      @ColorConverter() required final Color color}) = _$MapModelImpl;
  _MapModel._() : super._();

  factory _MapModel.fromJson(Map<String, dynamic> json) =
      _$MapModelImpl.fromJson;

  @override
  String get mapName;
  @override
  int get ownerId;
  @override
  List<FriendModel> get friends;
  @override
  Prediction get location;
  @override
  DateTime get selectedDate;
  @override
  List<Expense> get expenses;
  @override
  bool get isSharedMap;
  @override
  DateTime? get lastExpensesUpdate;
  @override
  @ColorConverter()
  Color get color;
  @override
  @JsonKey(ignore: true)
  _$$MapModelImplCopyWith<_$MapModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
