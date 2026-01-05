part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    @Default([]) List<DayExpense> allDayExpenses,
    @Default([]) List<Expense> allExpenses,
    @Default([]) List<Expense> incomes,
    required DateTime monthFilter,
  }) = _HomeState;

  List<DayExpense> get monthDayExpense =>
      allDayExpenses.where((e) => e.date.isCurrentMonth).toList();

  List<Expense> get monthExpenses =>
      allExpenses.where((e) => e.datetime.isCurrentMonth).toList();

  List<Expense> get monthIncomes =>
      incomes.where((e) => e.datetime.isCurrentMonth).toList();

  List<Expense> get incomesOnSelectedMonth =>
      incomes.where((e) => e.datetime.isSelectedMonth(monthFilter)).toList();

  double get balance => incomes.fold(0, (a, b) => a + b.price);

  double get monthBalance =>
      balance -
      allExpenses
          .where((e) => !e.datetime.isCurrentMonth)
          .fold(0, (a, b) => a + b.price);

  double get balanceOnSelectedMonth => incomes
      .where((e) => e.datetime.isSelectedMonth(monthFilter))
      .fold(0, (a, b) => a + b.price);

  double get percent {
    if (monthBalance == 0 && allSpends == 0) {
      return 0;
    } else if (monthBalance == 0 && allSpends != 0) {
      return 1.01;
    } else {
      return allSpends / monthBalance;
    }
  }

  double get allSpends => monthExpenses.fold(0, (a, b) => a + b.price);

  double get spendsOnSelectedMonth => allExpenses
      .where((e) => e.datetime.isSelectedMonth(monthFilter))
      .fold(0, (a, b) => a + b.price);

  List<Expense> get expenseOnSelectedMonth {
    final expenses = allExpenses.where(
      (e) => e.datetime.isSelectedMonth(monthFilter),
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

  List<DayExpense> get curWeekDayExpenses {
    final today = DateTime.now();

    final result = List.generate(7, (i) => DayExpense(date: today));

    final weekExp = allDayExpenses
        .where(
          (e) =>
              e.date.isBefore(
                today.endOfWeek.subtract(const Duration(days: 1)),
              ) &&
              e.date.isAfter(
                today.startOfWeek.subtract(const Duration(days: 1)),
              ),
        )
        .toList();

    for (final dayExp in weekExp) {
      result[dayExp.date.weekday - 1] = dayExp;
    }

    return result;
  }

  List<Expense> get comparedCurrentWeekExpenses {
    final Map<Category, Expense> tempExpenseMap = {};

    for (final expense in curWeekExpenses) {
      if (tempExpenseMap.keys.contains(expense.category)) {
        tempExpenseMap[expense.category] = tempExpenseMap[expense.category]!
            .copyWith(
              price: tempExpenseMap[expense.category]!.price + expense.price,
            );
      } else {
        tempExpenseMap[expense.category] = expense;
      }
    }

    final result = tempExpenseMap.values.toList();
    result.sort((a, b) => b.price.compareTo(a.price));

    return result;
  }

  List<Expense> get curWeekExpenses => allExpenses
      .where(
        (e) =>
            e.datetime.isAfter(
              DateTime.now().startOfWeek.subtract(const Duration(days: 1)),
            ) &&
            e.datetime.isBefore(
              DateTime.now().endOfWeek.subtract(const Duration(days: 1)),
            ),
      )
      .toList();

  double get maxWeekSpends => curWeekDayExpenses.isNotEmpty
      ? curWeekDayExpenses
            .reduce((a, b) => a.daySpend > b.daySpend ? a : b)
            .daySpend
      : 0;

  List<Expense> get todayExpenses => allDayExpenses
      .where((e) => e.date.isToday)
      .fold([], (a, b) => a + b.dayExpenses);
}
