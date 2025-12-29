import '/data/models/day_expenses/day_expenses.dart';
import '../models/expense/expense.dart';

abstract class LocalService {
  List<DayExpense> getDayExpenses({required List<Expense> expenses}) {
    return [];
  }
}

class MockLocalService implements LocalService {
  const MockLocalService();

  @override
  List<DayExpense> getDayExpenses({required List<Expense> expenses}) {
    if (expenses.isEmpty) return [];

    final Map<DateTime, List<Expense>> groupedMap = {};

    for (final expense in expenses) {
      final dateOnly = DateTime(
        expense.datetime.year,
        expense.datetime.month,
        expense.datetime.day,
      );

      if (!groupedMap.containsKey(dateOnly)) {
        groupedMap[dateOnly] = [];
      }
      groupedMap[dateOnly]!.add(expense);
    }

    final List<DayExpense> result = [];

    groupedMap.forEach((date, expenses) {
      expenses.sort((a, b) => b.datetime.compareTo(a.datetime));

      result.add(
        DayExpense(
          date: date,
          dayExpenses: expenses,
          dayName: expenses.first.datetime.weekday,
        ),
      );
    });

    result.sort((a, b) => b.date.compareTo(a.date));

    return result;
  }
}
