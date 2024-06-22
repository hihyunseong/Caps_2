part of 'expense_detail_bloc.dart';

@freezed
class ExpenseDetailEvent with _$ExpenseDetailEvent {
  const factory ExpenseDetailEvent.started({
    required int pinIdx,
  }) = _Started;
}
