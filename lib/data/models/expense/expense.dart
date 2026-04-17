import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable_uuid_converter/json_serializable_uuid_converter.dart';
import 'package:uuid/uuid.dart';

import '/utils/extensions.dart';
import '../category/category.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

@freezed
abstract class Expense with _$Expense {
  const Expense._();

  const factory Expense({
    @UuidValueConverter() required UuidValue id,
    @Default('') String name,
    required Category category,
    required DateTime datetime,
    required double price,
    @Default(false) bool isIncome,
    String? accountId,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  static Expense get empty => Expense(
    id: const UuidValue.fromNamespace(.url),
    category: Category.empty,
    datetime: DateTime.now(),
    price: 0,
  );

  bool get isEmpty => category == Category.empty;

  String get formattedPrice => price.toCleanString();
}

@freezed
abstract class GroupedExpense with _$GroupedExpense {
  const GroupedExpense._();

  const factory GroupedExpense({
    required Category category,
    required double amount,
    DateTime? dateFrom,
    DateTime? dateTo,
    required List<Expense> expenses,
  }) = _GroupedExpense;

  factory GroupedExpense.fromList(
    List<Expense> expenses, {
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    final amount = expenses.fold(0.0, (a, b) => a + b.price);

    return GroupedExpense(
      category: expenses.firstOrNull?.category ?? Category.empty,
      amount: amount,
      dateFrom: dateFrom,
      dateTo: dateTo,
      expenses: expenses,
    );
  }
}
