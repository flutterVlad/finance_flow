import 'dart:async';

import 'package:finance_flow/data/models/category/category.dart';
import 'package:finance_flow/domain/use_cases/add_expense_use_case.dart';
import 'package:finance_flow/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:finance_flow/presentation/screens/home_screen/features/settings/bloc/settings_bloc.dart';
import 'package:finance_flow/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '/data/models/expense/expense.dart';
import '/domain/use_cases/base_use_case.dart';
import '/domain/use_cases/get_day_expenses_use_case.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDayExpensesUseCase _getDayExpensesUseCase;
  final GetAllExpensesUseCase _getAllExpensesUseCase;
  final AddExpenseUseCase _addExpenseUseCase;
  late final StreamSubscription _settingsSubscription;

  HomeBloc({
    required GetDayExpensesUseCase getDayExpensesUseCase,
    required GetAllExpensesUseCase getAllExpensesUseCase,
    required AddExpenseUseCase addExpenseUseCase,
    required SettingsBloc settingsBloc,
  }) : _getDayExpensesUseCase = getDayExpensesUseCase,
       _getAllExpensesUseCase = getAllExpensesUseCase,
       _addExpenseUseCase = addExpenseUseCase,
       super(HomeState(monthFilter: DateTime.now())) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        init: (event) async => await _init(event, emit),
        updateData: (_) async => await _updateData(emit),
        filterMonth: (event) async => await _filterMonth(event, emit),
        clearFilter: (_) async => await _clearFilter(emit),
        addExpense: (event) async => await _addExpense(event, emit),
        getAllExpenses: (_) async => await _getAllExpenses(emit),
      );
    });

    _settingsSubscription = settingsBloc.stream.listen((state) {
      add(InitHomeEvent(accountId: state.selectedAccount?.uid?.uuid));
    });

    add(
      InitHomeEvent(accountId: settingsBloc.state.selectedAccount?.uid?.uuid),
    );
  }

  @override
  Future<void> close() {
    _settingsSubscription.cancel();
    return super.close();
  }

  Future<void> _init(InitHomeEvent event, Emitter<HomeState> emit) async {
    final allFetchedExpenses = await _getAllExpensesUseCase.execute(
      const NoParams(),
    );

    final incomes = allFetchedExpenses
        .where((e) => _incomeFilter(e, event.accountId))
        .toList();
    final allExpenses = allFetchedExpenses
        .where((e) => _expenseFilter(e, event.accountId))
        .toList();

    final dayExpenses = _getDayExpensesUseCase.execute(allExpenses);

    emit(
      state.copyWith(
        accountId: event.accountId,
        allDayExpenses: dayExpenses,
        allExpenses: allExpenses,
        incomes: incomes,
      ),
    );
  }

  bool _expenseFilter(Expense expense, String? accountId) {
    return !expense.isIncome && expense.accountId == accountId;
  }

  bool _incomeFilter(Expense expense, String? accountId) {
    return expense.isIncome && expense.accountId == accountId;
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
    await _addExpenseUseCase.execute(expense);
    add(const GetAllExpensesEvent());
  }

  Future<void> _getAllExpenses(Emitter<HomeState> emit) async {
    final fetchedExpenses = await _getAllExpensesUseCase.execute(
      const NoParams(),
    );

    final incomes = fetchedExpenses
        .where((e) => _incomeFilter(e, state.accountId))
        .toList();
    final expenses = fetchedExpenses
        .where((e) => _expenseFilter(e, state.accountId))
        .toList();
    final dayExpenses = _getDayExpensesUseCase.execute(expenses);

    emit(
      state.copyWith(
        allExpenses: expenses,
        allDayExpenses: dayExpenses,
        incomes: incomes,
      ),
    );
  }
}
