import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_model.freezed.dart';

part 'pin_model.g.dart';

@freezed
class PinModel with _$PinModel {
  const factory PinModel({
    required int pinIdx,
    required String header,
    required String title,
    required String memo,
    required String category,
    required int cost,
    required int lat,
    required int lon,
    required String file,
  }) = _PinModel;

  factory PinModel.fromJson(Map<String, dynamic> json) =>
      _$PinModelFromJson(json);
}
