import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_friend_model.freezed.dart';
part 'request_friend_model.g.dart';

@freezed
class RequestFriendModel with _$RequestFriendModel {
  factory RequestFriendModel({
    required int friendIdx,
    required String email,
    required String username,
    String? profile,
    @JsonKey(name: 'created_At') required DateTime createdAt,
  }) = _RequestFriendModel;

  factory RequestFriendModel.fromJson(Map<String, dynamic> json) =>
      _$RequestFriendModelFromJson(json);
}
