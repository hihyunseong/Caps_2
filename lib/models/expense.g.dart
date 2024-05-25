// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      expenseLocationName: json['expenseLocationName'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      content: json['content'] as String,
      memo: json['memo'] as String,
      date: DateTime.parse(json['date'] as String),
      imagePath: json['imagePath'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      map: MapModel.fromJson(json['map'] as Map<String, dynamic>),
      payMethod: $enumDecode(_$PayMethodEnumMap, json['payMethod']),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'expenseLocationName': instance.expenseLocationName,
      'amount': instance.amount,
      'category': _$CategoryEnumMap[instance.category]!,
      'content': instance.content,
      'memo': instance.memo,
      'date': instance.date.toIso8601String(),
      'imagePath': instance.imagePath,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'map': instance.map,
      'payMethod': _$PayMethodEnumMap[instance.payMethod]!,
    };

const _$CategoryEnumMap = {
  Category.food: 'food',
  Category.cafe: 'cafe',
  Category.alcohol: 'alcohol',
  Category.photo: 'photo',
  Category.shopping: 'shopping',
  Category.gift: 'gift',
  Category.plus: 'plus',
};

const _$PayMethodEnumMap = {
  PayMethod.creditCatd: 'creditCatd',
  PayMethod.checkCard: 'checkCard',
  PayMethod.cash: 'cash',
  PayMethod.accountTransfer: 'accountTransfer',
};
