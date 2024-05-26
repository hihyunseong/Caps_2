// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapModelImpl _$$MapModelImplFromJson(Map<String, dynamic> json) =>
    _$MapModelImpl(
      mapName: json['mapName'] as String,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      location: Prediction.fromJson(json['location'] as Map<String, dynamic>),
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: const ColorConverter().fromJson(json['color'] as String),
    );

Map<String, dynamic> _$$MapModelImplToJson(_$MapModelImpl instance) =>
    <String, dynamic>{
      'mapName': instance.mapName,
      'friends': instance.friends,
      'location': instance.location,
      'selectedDate': instance.selectedDate.toIso8601String(),
      'expenses': instance.expenses,
      'color': const ColorConverter().toJson(instance.color),
    };
