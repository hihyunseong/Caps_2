import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_shared_map_model.freezed.dart';
part 'request_shared_map_model.g.dart';

@freezed
class RequestSharedMapModel with _$RequestSharedMapModel {
  const factory RequestSharedMapModel({
    required String title,
    required String color,
    required double lat,
    required double lon,
    required String selectedDate,
  }) = _RequestSharedMapModel;

  factory RequestSharedMapModel.fromJson(Map<String, dynamic> json) =>
      _$RequestSharedMapModelFromJson(json);
}
