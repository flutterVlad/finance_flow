import '/data/hive_boxes.dart';
import '/data/models/expense/expense.dart';
import '/data/service/hive_service.dart';
import '/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  const ExpenseRepositoryImpl({required this.hiveService});

  final HiveService hiveService;

  @override
  Future<void> addExpense(Expense expense) async {
    await hiveService.putData<Expense>(
      expense.id.uuid,
      expense,
      boxKey: HiveBoxes.expenses(expense.accountId),
    );
  }

  @override
  Future<void> deleteExpense(Expense expense) async {
    await hiveService.deleteData<Expense>(
      expense.id.uuid,
      boxKey: HiveBoxes.expenses(expense.accountId),
    );
  }

  @override
  Future<List<Expense>> getAllExpenses(String? accountId) async {
    final result = await hiveService.getAllData<Expense>(
      boxKey: HiveBoxes.expenses(accountId),
    );

    return result;
  }

  @override
  Future<void> deleteAllExpenses(String? accountId) async {
    await hiveService.deleteAllData<Expense>(
      boxKey: HiveBoxes.expenses(accountId),
    );
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await hiveService.updateData<Expense>(
      expense.id.uuid,
      expense,
      boxKey: HiveBoxes.expenses(expense.accountId),
    );
  }
}
