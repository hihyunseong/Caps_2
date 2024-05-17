// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyExpenseImpl _$$DailyExpenseImplFromJson(Map<String, dynamic> json) =>
    _$DailyExpenseImpl(
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DailyExpenseImplToJson(_$DailyExpenseImpl instance) =>
    <String, dynamic>{
      'expenses': instance.expenses,
    };
