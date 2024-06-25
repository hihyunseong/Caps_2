import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_info_model.freezed.dart';
part 'friend_info_model.g.dart';

@freezed
class FriendInfoModel with _$FriendInfoModel {
  const factory FriendInfoModel({
    required int idx,
    required String email,
    required String name,
    String? profile,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FriendInfoModel;

  factory FriendInfoModel.fromJson(Map<String, dynamic> json) =>
      _$FriendInfoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
