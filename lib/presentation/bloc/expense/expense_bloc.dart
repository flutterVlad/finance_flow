import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '/data/models/expense/expense.dart';
import '/domain/repositories/expense_repository.dart';
import '/presentation/bloc/settings/settings_bloc.dart';
import '/utils/extensions.dart';

part 'expense_bloc.freezed.dart';
part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({
    required ExpenseRepository expenseRepository,
    required SettingsBloc settingsBloc,
  }) : _expenseRepository = expenseRepository,
       super(ExpenseState(monthFilter: DateTime.now())) {
    on<ExpenseEvent>((event, emit) async {
      await event.map(
        init: (event) async => await _init(event, emit),
        filterMonth: (event) async => await _filterMonth(event, emit),
        clearFilter: (_) async => await _clearFilter(emit),
        addExpense: (event) async => await _addExpense(event, emit),
        getAllExpenses: (_) async => await _getAllExpenses(emit),
        deleteExpense: (event) async => await _deleteExpense(event, emit),
        updateExpense: (event) async => await _updateExpense(event, emit),
      );
    });

    _settingsSubscription = settingsBloc.stream.listen((state) {
      add(.init(accountId: state.selectedAccount?.uid?.uuid));
    });
  }
  final ExpenseRepository _expenseRepository;
  late final StreamSubscription _settingsSubscription;

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    return super.close();
  }

  Future<void> _init(
    ExpenseEvent$Init event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(accountId: event.accountId));
    add(const .getAllExpenses());
  }

  Future<void> _filterMonth(
    ExpenseEvent$FilterMonth event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(monthFilter: event.date));
  }

  Future<void> _clearFilter(Emitter<ExpenseState> emit) async {
    emit(state.copyWith(monthFilter: DateTime.now()));
  }

  Future<void> _addExpense(
    ExpenseEvent$Add event,
    Emitter<ExpenseState> emit,
  ) async {
    final expense = event.expense.copyWith(accountId: state.accountId);
    await _expenseRepository.addExpense(expense);
    add(const .getAllExpenses());
  }

  Future<void> _getAllExpenses(Emitter<ExpenseState> emit) async {
    final fetchedExpenses = await _expenseRepository.getAllExpenses(
      state.accountId,
    );

    final incomes = fetchedExpenses.where((e) => e.isIncome).toList();
    final expenses = fetchedExpenses.where((e) => !e.isIncome).toList();
    final dayExpenses = ExpenseRepository.getDayExpenses(expenses: expenses);

    emit(
      state.copyWith(
        allExpenses: expenses,
        allDayExpenses: dayExpenses,
        incomes: incomes,
      ),
    );
  }

  Future<void> _deleteExpense(
    ExpenseEvent$Delete event,
    Emitter<ExpenseState> emit,
  ) async {
    await _expenseRepository.deleteExpense(event.expense);
    add(const .getAllExpenses());
  }

  Future<void> _updateExpense(
    ExpenseEvent$Update event,
    Emitter<ExpenseState> emit,
  ) async {
    await _expenseRepository.updateExpense(event.expense);
    add(const .getAllExpenses());
  }
}
