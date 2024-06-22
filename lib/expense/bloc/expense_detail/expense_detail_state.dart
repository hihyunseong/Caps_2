part of 'expense_detail_bloc.dart';

@freezed
class ExpenseDetailState with _$ExpenseDetailState {
  const factory ExpenseDetailState.initial() = _Initial;
  const factory ExpenseDetailState.progress() = _Progress;
  const factory ExpenseDetailState.success({
    required String response,
  }) = _Success;
  const factory ExpenseDetailState.failure({
    String? errorMessage,
  }) = _Failure;
}
