// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      amount: (json['amount'] as num).toDouble(),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      content: json['content'] as String,
      memo: json['memo'] as String,
      date: DateTime.parse(json['date'] as String),
      imagePath: json['imagePath'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'category': _$CategoryEnumMap[instance.category]!,
      'content': instance.content,
      'memo': instance.memo,
      'date': instance.date.toIso8601String(),
      'imagePath': instance.imagePath,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

const _$CategoryEnumMap = {
  Category.sleep: 'sleep',
  Category.transport: 'transport',
  Category.food: 'food',
  Category.shopping: 'shopping',
  Category.etc: 'etc',
};
