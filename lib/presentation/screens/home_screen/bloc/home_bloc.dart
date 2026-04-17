import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '/data/models/expense/expense.dart';
import '/domain/repositories/expense_repository.dart';
import '/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import '/utils/extensions.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required ExpenseRepository expenseRepository,
    required SettingsBloc settingsBloc,
  }) : _expenseRepository = expenseRepository,
       super(HomeState(monthFilter: DateTime.now())) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        init: (event) async => await _init(event, emit),
        updateData: (_) async => await _updateData(emit),
        filterMonth: (event) async => await _filterMonth(event, emit),
        clearFilter: (_) async => await _clearFilter(emit),
        addExpense: (event) async => await _addExpense(event, emit),
        getAllExpenses: (_) async => await _getAllExpenses(emit),
        deleteExpense: (event) async => await _deleteExpense(event, emit),
        updateExpense: (event) async => await _updateExpense(event, emit),
      );
    });

    _settingsSubscription = settingsBloc.stream.listen((state) {
      add(InitHomeEvent(accountId: state.selectedAccount?.uid?.uuid));
    });

    add(
      InitHomeEvent(accountId: settingsBloc.state.selectedAccount?.uid?.uuid),
    );
  }
  final ExpenseRepository _expenseRepository;
  late final StreamSubscription _settingsSubscription;

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    return super.close();
  }

  Future<void> _init(InitHomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(accountId: event.accountId));
    add(const GetAllExpensesEvent());
  }

  Future<void> _updateData(Emitter<HomeState> emit) async {}

  Future<void> _filterMonth(
    FilterMonthEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(monthFilter: event.date));
  }

  Future<void> _clearFilter(Emitter<HomeState> emit) async {
    emit(state.copyWith(monthFilter: DateTime.now()));
  }

  Future<void> _addExpense(
    AddExpenseEvent event,
    Emitter<HomeState> emit,
  ) async {
    final expense = event.expense.copyWith(accountId: state.accountId);
    await _expenseRepository.addExpense(expense);
    add(const GetAllExpensesEvent());
  }

  Future<void> _getAllExpenses(Emitter<HomeState> emit) async {
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
    DeleteExpenseEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _expenseRepository.deleteExpense(event.expense);
    add(const GetAllExpensesEvent());
  }

  Future<void> _updateExpense(
    UpdateExpenseEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _expenseRepository.updateExpense(event.expense);
    add(const GetAllExpensesEvent());
  }
}
