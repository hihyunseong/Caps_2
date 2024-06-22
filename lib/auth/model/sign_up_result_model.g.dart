// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpResultModelImpl _$$SignUpResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SignUpResultModelImpl(
      idx: json['idx'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      profile: json['profile'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SignUpResultModelImplToJson(
        _$SignUpResultModelImpl instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'email': instance.email,
      'name': instance.name,
      'profile': instance.profile,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
