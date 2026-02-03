import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable_uuid_converter/json_serializable_uuid_converter.dart';
import 'package:uuid/uuid.dart';

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

  static Expense get empty => Expense(
    id: const UuidValue.fromNamespace(.url),
    category: Category.empty,
    datetime: DateTime.now(),
    price: 0,
  );

  bool get isEmpty => category == Category.empty;

  String get formattedPrice => price.toStringAsFixed(2);

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
