import '/data/data_sources/local_datasource.dart';
import '/data/models/expense/expense.dart';
import 'base_use_case.dart';

class UpdateDataUseCase implements BaseUseCase<NoParams, List<Expense>> {
  final LocalService localService;

  const UpdateDataUseCase({required this.localService});

  @override
  List<Expense> execute(NoParams input) {
    return LocalService.updateExpenses();
  }
}
