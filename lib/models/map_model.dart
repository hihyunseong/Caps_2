import 'dart:ui';

import 'package:caps_2/friend/model/friend_model.dart';
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
    required int ownerId,
    @Default(0) int sharedOwnerId,
    required List<FriendModel> friends,
    required Prediction location,
    required DateTime selectedDate,
    required List<Expense> expenses,
    required bool isSharedMap,
    DateTime? lastExpensesUpdate,
    @ColorConverter() required Color color,
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

  bool get isSharedMap => friends.isNotEmpty;
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) {
    return Color(int.parse(json, radix: 16));
  }

  @override
  String toJson(Color color) {
    return color.value.toRadixString(16).toUpperCase();
  }
}
