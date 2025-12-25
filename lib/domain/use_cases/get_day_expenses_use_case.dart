import '/data/data_sources/local_datasource.dart';
import '/data/models/day_expenses/day_expenses.dart';
import '/data/models/expense/expense.dart';
import 'base_use_case.dart';

class GetDayExpensesUseCase
    implements BaseUseCase<List<Expense>, List<DayExpense>> {
  final MockLocalService _localService;

  const GetDayExpensesUseCase({required MockLocalService localService})
    : _localService = localService;

  @override
  List<DayExpense> execute(List<Expense> input) {
    return _localService.getDayExpenses(expenses: input);
  }
}
