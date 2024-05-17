import 'package:caps_2/models/expense.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

part 'map_model.freezed.dart';
part 'map_model.g.dart';

@freezed
class MapModel with _$MapModel {
  factory MapModel({
    required String mapName,
    required List<String> friends,
    required Prediction location,
    required DateTime selectedDate,
    required List<Expense> expenses,
  }) = _MapModel;

  factory MapModel.fromJson(Map<String, dynamic> json) =>
      _$MapModelFromJson(json);

  MapModel._();

  LatLng? get latLng => location.lat == null || location.lng == null
      ? null
      : LatLng(
          double.tryParse(location.lat!) ?? 0,
          double.tryParse(location.lng!) ?? 0,
        );

  int get totalExpenses => expenses.fold<int>(
      0, (previousValue, element) => previousValue + element.amount.toInt());
}
