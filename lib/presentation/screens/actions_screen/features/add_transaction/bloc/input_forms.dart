import 'package:formz/formz.dart';

import '/data/models/category/category.dart';

enum InputError { empty, invalid }

class TransactionNameInput extends FormzInput<String, InputError> {
  const TransactionNameInput.pure({String value = ''}) : super.pure(value);

  const TransactionNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputError? validator(String value) {
    return value.isEmpty ? InputError.empty : null;
  }
}

class TransactionAmountInput extends FormzInput<String, InputError> {
  const TransactionAmountInput.pure({String value = ''}) : super.pure(value);

  const TransactionAmountInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputError? validator(String value) {
    if (value.isEmpty) return InputError.empty;
    if (double.tryParse(value)?.isNegative ?? false) return InputError.invalid;
    return null;
  }
}

class TransactionCategoryInput extends FormzInput<Category, InputError> {
  const TransactionCategoryInput.pure({Category value = Category.empty})
    : super.pure(Category.empty);

  const TransactionCategoryInput.dirty({Category value = Category.empty})
    : super.dirty(value);

  @override
  InputError? validator(Category value) {
    return value == Category.empty ? InputError.empty : null;
  }
}

class TransactionDateTimeInput extends FormzInput<DateTime, InputError> {
  TransactionDateTimeInput.pure({DateTime? value})
    : super.pure(value ?? DateTime.now());

  TransactionDateTimeInput.dirty({DateTime? value})
    : super.dirty(value ?? DateTime.now());

  @override
  InputError? validator(DateTime value) {
    return value.isAfter(DateTime.now()) ? InputError.invalid : null;
  }
}
