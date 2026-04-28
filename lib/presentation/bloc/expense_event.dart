part of 'expense_bloc.dart';

@freezed
abstract class ExpenseEvent with _$ExpenseEvent {
  const factory ExpenseEvent.init({String? accountId}) = ExpenseEvent$Init;

  const factory ExpenseEvent.filterMonth(DateTime date) =
      ExpenseEvent$FilterMonth;

  const factory ExpenseEvent.clearFilter() = ExpenseEvent$ClearFilter;

  const factory ExpenseEvent.addExpense(Expense expense) = ExpenseEvent$Add;

  const factory ExpenseEvent.getAllExpenses() = ExpenseEvent$GetAll;

  const factory ExpenseEvent.deleteExpense(Expense expense) =
      ExpenseEvent$Delete;

  const factory ExpenseEvent.updateExpense(Expense expense) =
      ExpenseEvent$Update;
}
