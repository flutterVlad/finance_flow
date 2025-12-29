import '/data/models/expense/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);

  Future<List<Expense>> getAllExpenses();

  Future<void> deleteExpense(Expense expense);

  Future<void> deleteAllExpenses();
}
