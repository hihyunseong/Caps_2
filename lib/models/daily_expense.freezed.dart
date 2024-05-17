// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_expense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyExpense _$DailyExpenseFromJson(Map<String, dynamic> json) {
  return _DailyExpense.fromJson(json);
}

/// @nodoc
mixin _$DailyExpense {
  List<Expense> get expenses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyExpenseCopyWith<DailyExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyExpenseCopyWith<$Res> {
  factory $DailyExpenseCopyWith(
          DailyExpense value, $Res Function(DailyExpense) then) =
      _$DailyExpenseCopyWithImpl<$Res, DailyExpense>;
  @useResult
  $Res call({List<Expense> expenses});
}

/// @nodoc
class _$DailyExpenseCopyWithImpl<$Res, $Val extends DailyExpense>
    implements $DailyExpenseCopyWith<$Res> {
  _$DailyExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
  }) {
    return _then(_value.copyWith(
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyExpenseImplCopyWith<$Res>
    implements $DailyExpenseCopyWith<$Res> {
  factory _$$DailyExpenseImplCopyWith(
          _$DailyExpenseImpl value, $Res Function(_$DailyExpenseImpl) then) =
      __$$DailyExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Expense> expenses});
}

/// @nodoc
class __$$DailyExpenseImplCopyWithImpl<$Res>
    extends _$DailyExpenseCopyWithImpl<$Res, _$DailyExpenseImpl>
    implements _$$DailyExpenseImplCopyWith<$Res> {
  __$$DailyExpenseImplCopyWithImpl(
      _$DailyExpenseImpl _value, $Res Function(_$DailyExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenses = null,
  }) {
    return _then(_$DailyExpenseImpl(
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyExpenseImpl extends _DailyExpense {
  _$DailyExpenseImpl({required final List<Expense> expenses})
      : _expenses = expenses,
        super._();

  factory _$DailyExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyExpenseImplFromJson(json);

  final List<Expense> _expenses;
  @override
  List<Expense> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  String toString() {
    return 'DailyExpense(expenses: $expenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyExpenseImpl &&
            const DeepCollectionEquality().equals(other._expenses, _expenses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_expenses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyExpenseImplCopyWith<_$DailyExpenseImpl> get copyWith =>
      __$$DailyExpenseImplCopyWithImpl<_$DailyExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyExpenseImplToJson(
      this,
    );
  }
}

abstract class _DailyExpense extends DailyExpense {
  factory _DailyExpense({required final List<Expense> expenses}) =
      _$DailyExpenseImpl;
  _DailyExpense._() : super._();

  factory _DailyExpense.fromJson(Map<String, dynamic> json) =
      _$DailyExpenseImpl.fromJson;

  @override
  List<Expense> get expenses;
  @override
  @JsonKey(ignore: true)
  _$$DailyExpenseImplCopyWith<_$DailyExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
