part of 'expense.dart';

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      amount: (json['amount'] as num).toDouble(),
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      content: json['content'] as String,
      memo: json['memo'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'category': _$CategoryEnumMap[instance.category]!,
      'content': instance.content,
      'memo': instance.memo,
      'date': instance.date.toIso8601String(),
    };

const _$CategoryEnumMap = {
  Category.sleep: 'sleep',
  Category.transport: 'transport',
  Category.food: 'food',
  Category.shopping: 'shopping',
  Category.etc: 'etc',
};
