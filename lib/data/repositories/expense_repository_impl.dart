import '/data/models/expense/expense.dart';
import '/data/service/hive_service.dart';
import '/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final HiveService hiveService;

  const ExpenseRepositoryImpl({required this.hiveService});

  @override
  Future<void> addExpense(Expense expense) async {
    await hiveService.putData<Expense>(expense.hashCode, expense);
  }

  @override
  Future<void> deleteExpense(Expense expense) async {
    await hiveService.deleteData<Expense>(expense.toString());
  }

  @override
  Future<List<Expense>> getAllExpenses() async {
    final result = await hiveService.getAllData<Expense>();

    return result;
  }
}
