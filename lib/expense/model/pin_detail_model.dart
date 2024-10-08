import 'package:caps_2/expense/model/friend_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_detail_model.freezed.dart';
part 'pin_detail_model.g.dart';

@freezed
class PinDetailModel with _$PinDetailModel {
  const factory PinDetailModel({
    required int pinIdx,
    required String writer,
    required String header,
    required String title,
    required String memo,
    required String category,
    required String method,
    required int cost,
    required int day,
    required String place,
    required List<FriendInfoModel> list,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? file,
  }) = _PinDetailModel;

  factory PinDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PinDetailModelFromJson(json);
}
