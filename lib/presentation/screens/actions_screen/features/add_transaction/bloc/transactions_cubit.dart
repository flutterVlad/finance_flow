import 'package:finance_flow/data/models/category/category.dart';
import 'package:finance_flow/data/models/expense/expense.dart';
import 'package:finance_flow/presentation/screens/actions_screen/features/add_transaction/bloc/input_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'transactions_cubit.freezed.dart';
part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit()
    : super(
        TransactionsState(
          datetimeInput: TransactionDateTimeInput.dirty(value: DateTime.now()),
        ),
      );

  void setName(String? name) {
    emit(
      state.copyWith(nameInput: TransactionNameInput.dirty(value: name ?? '')),
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

  void clear() {
    emit(
      TransactionsState(
        datetimeInput: TransactionDateTimeInput.dirty(value: DateTime.now()),
        isIncome: false,
      ),
    );
  }
}
