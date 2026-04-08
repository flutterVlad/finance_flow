import '/data/models/expense/expense.dart';
import '/data/service/hive_service.dart';
import '/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final HiveService hiveService;

  const ExpenseRepositoryImpl({required this.hiveService});

  @override
  Future<void> addExpense(Expense expense) async {
    await hiveService.putData<Expense>(
      expense.id.uuid,
      expense,
      boxKey: expense.boxKey,
    );
  }

  @override
  Future<void> deleteExpense(Expense expense) async {
    await hiveService.deleteData<Expense>(
      expense.id.uuid,
      boxKey: expense.boxKey,
    );
  }

  @override
  Future<List<Expense>> getAllExpenses(String? accountId) async {
    final result = await hiveService.getAllData<Expense>(
      boxKey: "Expense${accountId ?? ''}",
    );

    return result;
  }

  @override
  Future<void> deleteAllExpenses(String? accountId) async {
    await hiveService.deleteAllData<Expense>(
      boxKey: "Expense${accountId ?? ''}",
    );
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await hiveService.updateData<Expense>(
      expense.id.uuid,
      expense,
      boxKey: expense.boxKey,
    );
  }
}
