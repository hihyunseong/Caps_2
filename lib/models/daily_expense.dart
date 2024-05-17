import 'package:caps_2/models/expense.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_expense.freezed.dart';
part 'daily_expense.g.dart';

@freezed
class DailyExpense with _$DailyExpense {
  factory DailyExpense({
    required List<Expense> expenses,
  }) = _DailyExpense;

  factory DailyExpense.fromJson(Map<String, dynamic> json) =>
      _$DailyExpenseFromJson(json);

  DailyExpense._();

  double get totalAmount => expenses.fold(
      0, (previousValue, element) => previousValue + element.amount);

  DateTime get tourDay => expenses.first.tourDay;
}
