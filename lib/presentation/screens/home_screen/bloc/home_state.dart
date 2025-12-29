part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default([]) List<DayExpense> dayExpenses,
    @Default([]) List<Expense> allExpenses,
    @Default([]) List<Expense> incomes,
    required DateTime monthFilter,
  }) = _HomeState;

  double get balance => incomes.fold(0, (a, b) => a + b.price);

  double get percent {
    if (balance == 0 && allSpends == 0) {
      return 0;
    } else if (balance == 0 && allSpends != 0) {
      return 1.01;
    } else {
      return allSpends / balance;
    }
  }

  List<Expense> get incomeOnCurrentMonth =>
      incomes.where((e) => e.datetime.isToday).toList();

  double get allSpends => dayExpenses.fold(0, (a, b) => a + b.daySpend);

  double get spendsOnCurrentMonth => dayExpenses
      .where((e) => e.date.month == monthFilter.month)
      .fold(0, (a, b) => a + b.daySpend);

  List<Expense> get expenseOnCurrentMonth {
    final expenses = allExpenses.where(
      (e) => e.datetime.month == monthFilter.month,
    );

    final Map<Category, Expense> mapExp = {};

    for (final expense in expenses) {
      if (mapExp.keys.contains(expense.category)) {
        mapExp[expense.category] =
            mapExp[expense.category]?.copyWith(
              price: mapExp[expense.category]?.price ?? 0 + expense.price,
            ) ??
            Expense.empty;
      } else {
        mapExp[expense.category] = expense;
      }
    }

    final result = mapExp.values.toList();
    result.sort((a, b) => a.price.compareTo(b.price));

    return result;
  }

  DateTime get startOfWeek {
    final today = DateTime.now();
    return today.subtract(Duration(days: today.weekday - 1));
  }

  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6));

  List<DayExpense> get curWeekDayExpenses {
    final result = List.generate(7, (i) => DayExpense(date: DateTime.now()));

    final weekExp = dayExpenses
        .where(
          (e) =>
              e.date.isBefore(endOfWeek.subtract(const Duration(days: 1))) &&
              e.date.isAfter(startOfWeek.subtract(const Duration(days: 1))),
        )
        .toList();

    for (final dayExp in weekExp) {
      result[dayExp.date.weekday - 1] = dayExp;
    }

    return result;
  }

  List<Expense> get curWeekExpenses => allExpenses
      .where(
        (e) =>
            e.datetime.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            e.datetime.isBefore(endOfWeek.subtract(const Duration(days: 1))),
      )
      .toList();

  double get maxWeekSpends => curWeekDayExpenses.isNotEmpty
      ? curWeekDayExpenses
            .reduce((a, b) => a.daySpend > b.daySpend ? a : b)
            .daySpend
      : 0;

  List<Expense> get todayExpenses => dayExpenses
      .where((e) => e.date.day == DateTime.now().day)
      .fold([], (a, b) => a + b.dayExpenses);
}

enum BudgetInputError { empty, invalid }

class BudgetInput extends FormzInput<String, BudgetInputError> {
  const BudgetInput.pure() : super.pure('');

  const BudgetInput.dirty({String value = ''}) : super.dirty(value);

  @override
  BudgetInputError? validator(String value) {
    if (value.isEmpty) return BudgetInputError.empty;
    if (double.tryParse(value)?.isNegative ?? false) {
      return BudgetInputError.invalid;
    }
    return null;
  }
}
