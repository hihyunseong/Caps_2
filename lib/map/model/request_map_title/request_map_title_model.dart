import 'dart:ui';

import 'package:caps_2/models/map_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_map_title_model.freezed.dart';

part 'request_map_title_model.g.dart';

@freezed
class RequestMapTitleModel with _$RequestMapTitleModel {
  const factory RequestMapTitleModel({
    required String title,
    @ColorConverter() required Color color,
    required int lat,
    required int lon,
    required DateTime selectedDate,
  }) = _RequestMapTitleModel;

  factory RequestMapTitleModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMapTitleModelFromJson(json);
}
