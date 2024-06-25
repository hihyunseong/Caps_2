import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto_model.freezed.dart';

part 'dto_model.g.dart';

@freezed
class DtoModel with _$DtoModel {
  const factory DtoModel({
    required String place,
    required String header,
    required String title,
    required String method,
    required String category,
    required String memo,
    required int cost,
    required double lat,
    required double lon,
    required List<int> list,
  }) = _DtoModel;

  factory DtoModel.fromJson(Map<String, dynamic> json) =>
      _$DtoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
