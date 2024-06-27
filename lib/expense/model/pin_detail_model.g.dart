// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PinDetailModelImpl _$$PinDetailModelImplFromJson(Map<String, dynamic> json) =>
    _$PinDetailModelImpl(
      pinIdx: json['pinIdx'] as int,
      writer: json['writer'] as String,
      header: json['header'] as String,
      title: json['title'] as String,
      memo: json['memo'] as String,
      category: json['category'] as String,
      method: json['method'] as String,
      cost: json['cost'] as int,
      day: json['day'] as int,
      place: json['place'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => FriendInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      file: json['file'] as String?,
    );

Map<String, dynamic> _$$PinDetailModelImplToJson(
        _$PinDetailModelImpl instance) =>
    <String, dynamic>{
      'pinIdx': instance.pinIdx,
      'writer': instance.writer,
      'header': instance.header,
      'title': instance.title,
      'memo': instance.memo,
      'category': instance.category,
      'method': instance.method,
      'cost': instance.cost,
      'day': instance.day,
      'place': instance.place,
      'list': instance.list,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'file': instance.file,
    };
