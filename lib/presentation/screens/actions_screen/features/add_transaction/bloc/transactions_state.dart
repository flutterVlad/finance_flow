part of 'transactions_cubit.dart';

@freezed
abstract class TransactionsState with _$TransactionsState {
  const TransactionsState._();

  const factory TransactionsState({
    @Default(TransactionNameInput.pure()) TransactionNameInput nameInput,
    @Default(TransactionAmountInput.pure()) TransactionAmountInput amountInput,
    @Default(TransactionCategoryInput.pure())
    TransactionCategoryInput categoryInput,
    required TransactionDateTimeInput datetimeInput,
    @Default(false) bool isIncome,
    @Default([]) List<Rate> rates,
    @Default(Currency.byn) Currency selectedCurrency,
  }) = _TransactionsState;

  Expense get validExpense => Expense(
    id: UuidValue.fromString(const Uuid().v4()),
    name: nameInput.value,
    category: categoryInput.value,
    datetime: datetimeInput.value,
    price: double.tryParse(amountInput.value) ?? 0,
    isIncome: isIncome,
  );

  bool get isFormValid =>
      nameInput.isValid &&
      amountInput.isValid &&
      categoryInput.isValid &&
      datetimeInput.isValid;

  bool get isIncomeCategorySelected => categoryInput.value.isIncome;

  Rate? getRate(Currency cur) => switch (cur) {
    .byn => rates.firstWhereOrNull(
      (e) => e.shortName == Currency.byn.shortName,
    ),
    .dollar => rates.firstWhereOrNull(
      (e) => e.shortName == Currency.dollar.shortName,
    ),
    .euro => rates.firstWhereOrNull(
      (e) => e.shortName == Currency.euro.shortName,
    ),
    .lir => rates.firstWhereOrNull(
      (e) => e.shortName == Currency.lir.shortName,
    ),
  };
}
