import 'package:formz/formz.dart';

import '/data/models/category/category.dart';

class TransactionNameInput extends FormzInput<String, String?> {
  const TransactionNameInput.pure({String value = ''}) : super.pure(value);

  const TransactionNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  String? validator(String value) {
    return value.isEmpty ? 'Field can not be an empty' : null;
  }
}

class TransactionAmountInput extends FormzInput<String, String?> {
  const TransactionAmountInput.pure({String value = ''}) : super.pure(value);

  const TransactionAmountInput.dirty({String value = ''}) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'Field can not be an empty';
    if (double.tryParse(value)?.isNegative ?? false) return 'Value invalid';
    return null;
  }
}

class TransactionCategoryInput extends FormzInput<Category, String?> {
  const TransactionCategoryInput.pure({Category value = Category.empty})
    : super.pure(Category.empty);

  const TransactionCategoryInput.dirty({Category value = Category.empty})
    : super.dirty(value);

  @override
  String? validator(Category value) {
    return value == Category.empty ? 'Field can not be an empty' : null;
  }
}

class TransactionDateTimeInput extends FormzInput<DateTime, String?> {
  TransactionDateTimeInput.pure({DateTime? value})
    : super.pure(value ?? DateTime.now());

  TransactionDateTimeInput.dirty({DateTime? value})
    : super.dirty(value ?? DateTime.now());

  @override
  String? validator(DateTime value) {
    return value.isAfter(DateTime.now())
        ? 'Date can not be laster than today'
        : null;
  }
}
