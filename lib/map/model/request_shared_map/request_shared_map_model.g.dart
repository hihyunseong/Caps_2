// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_shared_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestSharedMapModelImpl _$$RequestSharedMapModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestSharedMapModelImpl(
      title: json['title'] as String,
      color: json['color'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      selectedDate: json['selectedDate'] as String,
    );

Map<String, dynamic> _$$RequestSharedMapModelImplToJson(
        _$RequestSharedMapModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'lat': instance.lat,
      'lon': instance.lon,
      'selectedDate': instance.selectedDate,
    };
