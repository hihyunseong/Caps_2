import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto_model.freezed.dart';

part 'dto_model.g.dart';

@freezed
class DtoModel with _$DtoModel {
  const factory DtoModel({
    required String header,
    required String title,
    required String method,
    required String category,
    required String memo,
    required int cost,
    required double lat,
    required double lon,
  }) = _DtoModel;

  factory DtoModel.fromJson(Map<String, dynamic> json) =>
      _$DtoModelFromJson(json);
}
