import 'dart:async';

import 'package:collection/collection.dart';
import 'package:finance_flow/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '/data/models/category/category.dart';
import '/data/models/currency/currency.dart';
import '/data/models/expense/expense.dart';
import '/domain/repositories/currency_repository.dart';
import '/presentation/screens/actions_screen/features/add_transaction/bloc/input_forms.dart';

part 'transactions_cubit.freezed.dart';
part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final CurrencyRepository _currencyRepository;

  TransactionsCubit({required CurrencyRepository currencyRepository})
    : _currencyRepository = currencyRepository,
      super(
        TransactionsState(
          datetimeInput: TransactionDateTimeInput.dirty(value: DateTime.now()),
          categoryInput: TransactionCategoryInput.dirty(
            value: defaultCategories[3],
          ),
        ),
      );

  FutureOr<void> getCurrencyRate() async {
    if (state.rates.isNotEmpty && state.rates.first.date.isToday) return;

    final responseRates = await _currencyRepository.fetchRates();
    final rates = [
      Rate.blrRate,
      ...responseRates.where(
        (e) =>
            e.shortName == 'USD' ||
            e.shortName == 'EUR' ||
            e.shortName == "TRY",
      ),
    ];

    emit(state.copyWith(rates: rates));
  }

  void setCurrency(Currency cur) => emit(state.copyWith(selectedCurrency: cur));

  void setName(String? name) {
    emit(
      state.copyWith(nameInput: TransactionNameInput.dirty(value: name ?? '')),
    );
  }

  void initIncomeTransaction() {
    emit(
      state.copyWith(
        isIncome: true,
        categoryInput: TransactionCategoryInput.dirty(
          value: defaultCategories.firstWhere((e) => e.id == 33),
        ),
      ),
    );
  }

  void setAmount(String? amount) {
    emit(
      state.copyWith(
        amountInput: TransactionAmountInput.dirty(value: amount ?? ''),
      ),
    );
  }

  void setCategory(Category category) {
    emit(
      state.copyWith(
        categoryInput: TransactionCategoryInput.dirty(value: category),
        isIncome: category.isIncome,
      ),
    );
  }

  void setDate(DateTime date) {
    emit(
      state.copyWith(
        datetimeInput: TransactionDateTimeInput.dirty(value: date),
      ),
    );
  }

  void setIncome(bool newBool) {
    emit(state.copyWith(isIncome: newBool));
  }
}
