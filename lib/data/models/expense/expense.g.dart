// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Expense _$ExpenseFromJson(Map<String, dynamic> json) => _Expense(
  name: json['name'] as String? ?? '',
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  datetime: DateTime.parse(json['datetime'] as String),
  price: (json['price'] as num).toDouble(),
  isIncome: json['isIncome'] as bool? ?? false,
);

Map<String, dynamic> _$ExpenseToJson(_Expense instance) => <String, dynamic>{
  'name': instance.name,
  'category': instance.category,
  'datetime': instance.datetime.toIso8601String(),
  'price': instance.price,
  'isIncome': instance.isIncome,
};
