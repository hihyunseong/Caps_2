// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_map_title_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestMapTitleModelImpl _$$RequestMapTitleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestMapTitleModelImpl(
      title: json['title'] as String,
      color: json['color'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      selectedDate: json['selectedDate'] as String,
    );

Map<String, dynamic> _$$RequestMapTitleModelImplToJson(
        _$RequestMapTitleModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'color': instance.color,
      'lat': instance.lat,
      'lon': instance.lon,
      'selectedDate': instance.selectedDate,
    };
