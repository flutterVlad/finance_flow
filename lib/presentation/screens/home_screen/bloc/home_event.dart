part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  const factory HomeEvent.init() = InitHomeEvent;

  const factory HomeEvent.updateData() = UpdateHomeEvent;

  const factory HomeEvent.filterMonth(DateTime date) = FilterMonthEvent;

  const factory HomeEvent.clearFilter() = ClearMonthFilterEvent;

  const factory HomeEvent.addExpense(Expense expense) = AddExpenseEvent;

  const factory HomeEvent.getAllExpenses() = GetAllExpensesEvent;
}
