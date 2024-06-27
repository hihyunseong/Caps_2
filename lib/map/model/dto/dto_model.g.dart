// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DtoModelImpl _$$DtoModelImplFromJson(Map<String, dynamic> json) =>
    _$DtoModelImpl(
      place: json['place'] as String,
      header: json['header'] as String,
      title: json['title'] as String,
      method: json['method'] as String,
      category: json['category'] as String,
      memo: json['memo'] as String,
      cost: json['cost'] as int,
      day: json['day'] as int,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      list: (json['list'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$DtoModelImplToJson(_$DtoModelImpl instance) =>
    <String, dynamic>{
      'place': instance.place,
      'header': instance.header,
      'title': instance.title,
      'method': instance.method,
      'category': instance.category,
      'memo': instance.memo,
      'cost': instance.cost,
      'day': instance.day,
      'lat': instance.lat,
      'lon': instance.lon,
      'list': instance.list,
    };
