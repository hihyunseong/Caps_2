import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_map_title_model.freezed.dart';
part 'request_map_title_model.g.dart';

@freezed
class RequestMapTitleModel with _$RequestMapTitleModel {
  const factory RequestMapTitleModel({
    required String title,
    required String color,
    required double lat,
    required double lon,
    required String selectedDate,
  }) = _RequestMapTitleModel;

  factory RequestMapTitleModel.fromJson(Map<String, dynamic> json) =>
      _$RequestMapTitleModelFromJson(json);
}
