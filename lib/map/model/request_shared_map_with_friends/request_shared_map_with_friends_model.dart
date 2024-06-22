import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_shared_map_with_friends_model.freezed.dart';

part 'request_shared_map_with_friends_model.g.dart';

@freezed
class RequestSharedMapWithFriendsModel with _$RequestSharedMapWithFriendsModel {
  const factory RequestSharedMapWithFriendsModel({
    required int mapIdx,
    required int memberIdx,
  }) = _RequestSharedMapWithFriendsModel;

  factory RequestSharedMapWithFriendsModel.fromJson(
          Map<String, dynamic> json) =>
      _$RequestSharedMapWithFriendsModelFromJson(json);
}
