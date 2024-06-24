// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PinModelImpl _$$PinModelImplFromJson(Map<String, dynamic> json) =>
    _$PinModelImpl(
      pinIdx: json['pinIdx'] as int,
      header: json['header'] as String,
      title: json['title'] as String,
      memo: json['memo'] as String,
      category: json['category'] as String,
      cost: json['cost'] as int,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      file: json['file'] as String?,
    );

Map<String, dynamic> _$$PinModelImplToJson(_$PinModelImpl instance) =>
    <String, dynamic>{
      'pinIdx': instance.pinIdx,
      'header': instance.header,
      'title': instance.title,
      'memo': instance.memo,
      'category': instance.category,
      'cost': instance.cost,
      'lat': instance.lat,
      'lon': instance.lon,
      'file': instance.file,
    };
