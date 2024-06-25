// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SharedMapImpl _$$SharedMapImplFromJson(Map<String, dynamic> json) =>
    _$SharedMapImpl(
      idx: json['idx'] as int,
      title: json['title'] as String,
      color: json['color'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      pins: (json['pins'] as List<dynamic>).map((e) => e as int).toList(),
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => FriendModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SharedMapImplToJson(_$SharedMapImpl instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'title': instance.title,
      'color': instance.color,
      'lat': instance.lat,
      'lon': instance.lon,
      'pins': instance.pins,
      'selectedDate': instance.selectedDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'friends': instance.friends,
    };
