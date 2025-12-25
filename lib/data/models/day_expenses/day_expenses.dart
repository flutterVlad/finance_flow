import 'package:freezed_annotation/freezed_annotation.dart';

import '../expense/expense.dart';

part 'day_expenses.freezed.dart';
part 'day_expenses.g.dart';

@freezed
abstract class DayExpense with _$DayExpense {
  const DayExpense._();

  const factory DayExpense({
    @Default(0) int dayName,
    @Default([]) List<Expense> dayExpenses,
    required DateTime date,
  }) = _DayExpense;

  static final empty = DayExpense(date: DateTime.now());

  double get daySpend => dayExpenses.fold(.0, (a, b) => a + b.price);

  String get formattedAllSpends => daySpend.toStringAsFixed(2);

  factory DayExpense.fromJson(Map<String, dynamic> json) =>
      _$DayExpenseFromJson(json);
}
