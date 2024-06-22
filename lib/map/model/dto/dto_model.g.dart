// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DtoModelImpl _$$DtoModelImplFromJson(Map<String, dynamic> json) =>
    _$DtoModelImpl(
      header: json['header'] as String,
      title: json['title'] as String,
      method: json['method'] as String,
      category: json['category'] as String,
      memo: json['memo'] as String,
      cost: json['cost'] as int,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$$DtoModelImplToJson(_$DtoModelImpl instance) =>
    <String, dynamic>{
      'header': instance.header,
      'title': instance.title,
      'method': instance.method,
      'category': instance.category,
      'memo': instance.memo,
      'cost': instance.cost,
      'lat': instance.lat,
      'lon': instance.lon,
    };
