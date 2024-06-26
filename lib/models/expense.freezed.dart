// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  int get pinIdx => throw _privateConstructorUsedError;
  String get expenseLocationName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  MapModel get map => throw _privateConstructorUsedError;
  PayMethod get payMethod => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<FriendModel> get friends => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {int pinIdx,
      String expenseLocationName,
      double amount,
      Category category,
      String content,
      String memo,
      DateTime date,
      String? imagePath,
      double latitude,
      double longitude,
      MapModel map,
      PayMethod payMethod,
      DateTime createdAt,
      List<FriendModel> friends});

  $MapModelCopyWith<$Res> get map;
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinIdx = null,
    Object? expenseLocationName = null,
    Object? amount = null,
    Object? category = null,
    Object? content = null,
    Object? memo = null,
    Object? date = null,
    Object? imagePath = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? map = null,
    Object? payMethod = null,
    Object? createdAt = null,
    Object? friends = null,
  }) {
    return _then(_value.copyWith(
      pinIdx: null == pinIdx
          ? _value.pinIdx
          : pinIdx // ignore: cast_nullable_to_non_nullable
              as int,
      expenseLocationName: null == expenseLocationName
          ? _value.expenseLocationName
          : expenseLocationName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapModel,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as PayMethod,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      friends: null == friends
          ? _value.friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<FriendModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MapModelCopyWith<$Res> get map {
    return $MapModelCopyWith<$Res>(_value.map, (value) {
      return _then(_value.copyWith(map: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
          _$ExpenseImpl value, $Res Function(_$ExpenseImpl) then) =
      __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pinIdx,
      String expenseLocationName,
      double amount,
      Category category,
      String content,
      String memo,
      DateTime date,
      String? imagePath,
      double latitude,
      double longitude,
      MapModel map,
      PayMethod payMethod,
      DateTime createdAt,
      List<FriendModel> friends});

  @override
  $MapModelCopyWith<$Res> get map;
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
      _$ExpenseImpl _value, $Res Function(_$ExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pinIdx = null,
    Object? expenseLocationName = null,
    Object? amount = null,
    Object? category = null,
    Object? content = null,
    Object? memo = null,
    Object? date = null,
    Object? imagePath = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? map = null,
    Object? payMethod = null,
    Object? createdAt = null,
    Object? friends = null,
  }) {
    return _then(_$ExpenseImpl(
      pinIdx: null == pinIdx
          ? _value.pinIdx
          : pinIdx // ignore: cast_nullable_to_non_nullable
              as int,
      expenseLocationName: null == expenseLocationName
          ? _value.expenseLocationName
          : expenseLocationName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      map: null == map
          ? _value.map
          : map // ignore: cast_nullable_to_non_nullable
              as MapModel,
      payMethod: null == payMethod
          ? _value.payMethod
          : payMethod // ignore: cast_nullable_to_non_nullable
              as PayMethod,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      friends: null == friends
          ? _value._friends
          : friends // ignore: cast_nullable_to_non_nullable
              as List<FriendModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl extends _Expense {
  _$ExpenseImpl(
      {this.pinIdx = 0,
      required this.expenseLocationName,
      required this.amount,
      required this.category,
      required this.content,
      required this.memo,
      required this.date,
      this.imagePath,
      required this.latitude,
      required this.longitude,
      required this.map,
      required this.payMethod,
      required this.createdAt,
      required final List<FriendModel> friends})
      : _friends = friends,
        super._();

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  @JsonKey()
  final int pinIdx;
  @override
  final String expenseLocationName;
  @override
  final double amount;
  @override
  final Category category;
  @override
  final String content;
  @override
  final String memo;
  @override
  final DateTime date;
  @override
  final String? imagePath;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final MapModel map;
  @override
  final PayMethod payMethod;
  @override
  final DateTime createdAt;
  final List<FriendModel> _friends;
  @override
  List<FriendModel> get friends {
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friends);
  }

  @override
  String toString() {
    return 'Expense(pinIdx: $pinIdx, expenseLocationName: $expenseLocationName, amount: $amount, category: $category, content: $content, memo: $memo, date: $date, imagePath: $imagePath, latitude: $latitude, longitude: $longitude, map: $map, payMethod: $payMethod, createdAt: $createdAt, friends: $friends)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.pinIdx, pinIdx) || other.pinIdx == pinIdx) &&
            (identical(other.expenseLocationName, expenseLocationName) ||
                other.expenseLocationName == expenseLocationName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.map, map) || other.map == map) &&
            (identical(other.payMethod, payMethod) ||
                other.payMethod == payMethod) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._friends, _friends));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      pinIdx,
      expenseLocationName,
      amount,
      category,
      content,
      memo,
      date,
      imagePath,
      latitude,
      longitude,
      map,
      payMethod,
      createdAt,
      const DeepCollectionEquality().hash(_friends));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(
      this,
    );
  }
}

abstract class _Expense extends Expense {
  factory _Expense(
      {final int pinIdx,
      required final String expenseLocationName,
      required final double amount,
      required final Category category,
      required final String content,
      required final String memo,
      required final DateTime date,
      final String? imagePath,
      required final double latitude,
      required final double longitude,
      required final MapModel map,
      required final PayMethod payMethod,
      required final DateTime createdAt,
      required final List<FriendModel> friends}) = _$ExpenseImpl;
  _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  int get pinIdx;
  @override
  String get expenseLocationName;
  @override
  double get amount;
  @override
  Category get category;
  @override
  String get content;
  @override
  String get memo;
  @override
  DateTime get date;
  @override
  String? get imagePath;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  MapModel get map;
  @override
  PayMethod get payMethod;
  @override
  DateTime get createdAt;
  @override
  List<FriendModel> get friends;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
