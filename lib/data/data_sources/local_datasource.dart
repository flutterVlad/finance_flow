import 'dart:math';

import '/data/models/category/category.dart';
import '/data/models/day_expenses/day_expenses.dart';
import '../models/expense/expense.dart';

abstract class LocalService {
  List<DayExpense> getDayExpenses({required List<Expense> expenses}) {
    return [];
  }

  static List<Expense> generateMockExpenses([int count = 30]) {
    final List<Expense> res = [];

    for (int i = 0; i < count; i++) {
      final date = DateTime.now().subtract(
        Duration(days: Random().nextInt(30)),
      );

      final expense = Expense(
        category: defaultCategories[Random().nextInt(33)],
        datetime: date,
        price: Random().nextDouble() * 500 + 10,
      );
      res.add(expense);
    }

    return res;
  }

  static List<Expense> updateExpenses() {
    _cacheExpenses = null;
    return expenses;
  }

  static List<Expense>? _cacheExpenses;

  static List<Expense> get expenses {
    _cacheExpenses ??= LocalService.generateMockExpenses();
    return _cacheExpenses!;
  }
}

class MockLocalService implements LocalService {
  const MockLocalService();

  List<DayExpense> get dayExpense =>
      getDayExpenses(expenses: LocalService.expenses);

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
