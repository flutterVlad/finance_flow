// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DayExpense _$DayExpenseFromJson(Map<String, dynamic> json) => _DayExpense(
  dayName: (json['dayName'] as num?)?.toInt() ?? 0,
  dayExpenses:
      (json['dayExpenses'] as List<dynamic>?)
          ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  date: DateTime.parse(json['date'] as String),
);

Map<String, dynamic> _$DayExpenseToJson(_DayExpense instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'dayExpenses': instance.dayExpenses,
      'date': instance.date.toIso8601String(),
    };
