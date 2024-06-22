import 'package:caps_2/map/model/dto/dto_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_pin_model.freezed.dart';

part 'request_pin_model.g.dart';

@freezed
class RequestPinModel with _$RequestPinModel {
  const factory RequestPinModel({
    required DtoModel dto,
  }) = _RequestPinModel;

  factory RequestPinModel.fromJson(Map<String, dynamic> json) =>
      _$RequestPinModelFromJson(json);
}
