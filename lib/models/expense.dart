import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'category.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
class Expense with _$Expense {
  factory Expense({
    required double amount,
    required Category category,
    required String content,
    required String memo,
    required DateTime date,
    String? imagePath,
    required double latitude,
    required double longitude,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Expense._();

  LatLng get latLng => LatLng(latitude, longitude);
  DateTime get tourDay => DateTime(date.year, date.month, date.day);
}
