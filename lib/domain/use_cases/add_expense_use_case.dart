import '/data/models/expense/expense.dart';
import '/domain/repositories/expense_repository.dart';
import '/domain/use_cases/base_use_case.dart';

class AddExpenseUseCase implements FutureBaseUseCase<Expense, void> {
  final ExpenseRepository _expenseRepository;

  const AddExpenseUseCase({required ExpenseRepository expenseRepository})
    : _expenseRepository = expenseRepository;

  @override
  Future<void> execute(Expense input) async {
    await _expenseRepository.addExpense(input);
  }
}
