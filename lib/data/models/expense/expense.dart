import 'package:freezed_annotation/freezed_annotation.dart';

import '../category/category.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
abstract class Expense with _$Expense {
  const Expense._();

  const factory Expense({
    @Default('') String name,
    required Category category,
    required DateTime datetime,
    required double price,
    @Default(false) bool isIncome,
  }) = _Expense;

  static Expense get empty =>
      Expense(category: Category.empty, datetime: DateTime.now(), price: 0);

  String get formattedPrice => price.toStringAsFixed(2);

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
