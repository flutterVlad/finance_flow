import 'package:finance_flow/data/models/category/category.dart';
import 'package:finance_flow/domain/use_cases/add_expense_use_case.dart';
import 'package:finance_flow/domain/use_cases/get_all_expenses_use_case.dart';
import 'package:finance_flow/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
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

  // final GetMockExpensesUseCase _getMockExpensesUseCase;
  // final UpdateDataUseCase _updateDataUseCase;
  final GetAllExpensesUseCase _getAllExpensesUseCase;
  final AddExpenseUseCase _addExpenseUseCase;

  HomeBloc({
    required GetDayExpensesUseCase getDayExpensesUseCase,
    // required GetMockExpensesUseCase getMockExpensesUseCase,
    // required UpdateDataUseCase updateDataUseCase,
    required GetAllExpensesUseCase getAllExpensesUseCase,
    required AddExpenseUseCase addExpenseUseCase,
  }) : _getDayExpensesUseCase = getDayExpensesUseCase,
       // _getMockExpensesUseCase = getMockExpensesUseCase,
       // _updateDataUseCase = updateDataUseCase,
       _getAllExpensesUseCase = getAllExpensesUseCase,
       _addExpenseUseCase = addExpenseUseCase,
       super(HomeState(monthFilter: DateTime.now())) {
    on<HomeEvent>((event, emit) async {
      await event.map(
        init: (_) async => await _init(emit),
        updateData: (_) async => await _updateData(emit),
        filterMonth: (event) async => await _filterMonth(event, emit),
        clearFilter: (_) async => await _clearFilter(emit),
        addExpense: (event) async => await _addExpense(event, emit),
        getAllExpenses: (_) async => await _getAllExpenses(emit),
      );
    });

    add(const InitHomeEvent());
  }

  Future<void> _init(Emitter<HomeState> emit) async {
    // final allExpenses = _getMockExpensesUseCase.execute(const NoParams());
    final allExpenses = await _getAllExpensesUseCase.execute(const NoParams());

    final incomes = allExpenses.where((e) => e.isIncome).toList();
    final expenses = allExpenses.where((e) => !e.isIncome).toList();

    final dayExpenses = _getDayExpensesUseCase.execute(expenses);

    emit(
      state.copyWith(
        dayExpenses: dayExpenses,
        allExpenses: expenses,
        incomes: incomes,
      ),
    );
  }

  Future<void> _updateData(Emitter<HomeState> emit) async {
    // final allExpenses = _updateDataUseCase.execute(const NoParams());
    // final dayExpenses = _getDayExpensesUseCase.execute(allExpenses);
    // emit(state.copyWith(allExpenses: allExpenses, dayExpenses: dayExpenses));
  }

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
    await _addExpenseUseCase.execute(event.expense);
    add(const HomeEvent.getAllExpenses());
  }

  Future<void> _getAllExpenses(Emitter<HomeState> emit) async {
    final fetchedExpenses = await _getAllExpensesUseCase.execute(
      const NoParams(),
    );

    final incomes = fetchedExpenses.where((e) => e.isIncome).toList();
    final expenses = fetchedExpenses.where((e) => !e.isIncome).toList();
    final dayExpenses = _getDayExpensesUseCase.execute(expenses);

    emit(
      state.copyWith(
        allExpenses: expenses,
        dayExpenses: dayExpenses,
        incomes: incomes,
      ),
    );
  }
}
