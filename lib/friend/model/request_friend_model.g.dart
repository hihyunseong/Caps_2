// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestFriendModelImpl _$$RequestFriendModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestFriendModelImpl(
      friendIdx: json['friendIdx'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      profile: json['profile'] as String?,
      createdAt: DateTime.parse(json['created_At'] as String),
    );

Map<String, dynamic> _$$RequestFriendModelImplToJson(
        _$RequestFriendModelImpl instance) =>
    <String, dynamic>{
      'friendIdx': instance.friendIdx,
      'email': instance.email,
      'username': instance.username,
      'profile': instance.profile,
      'created_At': instance.createdAt.toIso8601String(),
    };
