import '/data/models/expense/expense.dart';
import '/domain/repositories/expense_repository.dart';
import '/domain/use_cases/base_use_case.dart';

class GetAllExpensesUseCase
    implements FutureBaseUseCase<NoParams, List<Expense>> {
  final ExpenseRepository _expenseRepository;

  const GetAllExpensesUseCase({required ExpenseRepository expenseRepository})
    : _expenseRepository = expenseRepository;

  @override
  Future<List<Expense>> execute(NoParams input) async {
    final result = await _expenseRepository.getAllExpenses();

    return result;
  }
}
