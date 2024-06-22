import 'dart:ui';

import 'package:caps_2/models/map_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_shared_map_model.freezed.dart';

part 'request_shared_map_model.g.dart';

@freezed
class RequestSharedMapModel with _$RequestSharedMapModel {
  const factory RequestSharedMapModel({
    required String title,
    required String color,
    required int lat,
    required int lon,
    required String selectedDate,
  }) = _RequestSharedMapModel;

  factory RequestSharedMapModel.fromJson(Map<String, dynamic> json) =>
      _$RequestSharedMapModelFromJson(json);
}
