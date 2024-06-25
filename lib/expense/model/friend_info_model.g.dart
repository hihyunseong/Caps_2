// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendInfoModelImpl _$$FriendInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FriendInfoModelImpl(
      idx: json['idx'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      profile: json['profile'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FriendInfoModelImplToJson(
        _$FriendInfoModelImpl instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'email': instance.email,
      'name': instance.name,
      'profile': instance.profile,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
