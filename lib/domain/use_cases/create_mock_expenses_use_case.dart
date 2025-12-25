import '/data/data_sources/local_datasource.dart';
import '/data/models/expense/expense.dart';
import 'base_use_case.dart';

class GetMockExpensesUseCase implements BaseUseCase<NoParams, List<Expense>> {
  const GetMockExpensesUseCase();

  @override
  List<Expense> execute(NoParams input) {
    return LocalService.expenses;
  }
}
