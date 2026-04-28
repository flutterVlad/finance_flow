import 'package:finance_flow/presentation/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/data/models/expense/expense.dart';
import '/l10n/app_localizations.dart';
import '/presentation/screens/wallet_screen/widgets/scatter_statistics.dart';
import '/utils/extensions.dart';
import '/utils/theme.dart';
import 'scatter_expenses_list.dart';

class WeeklyExpense extends StatefulWidget {
  const WeeklyExpense({super.key});

  @override
  State<WeeklyExpense> createState() => _WeeklyExpenseState();
}

class _WeeklyExpenseState extends State<WeeklyExpense> {
  DateTime date = DateTime.now();
  late final PageController _controller;

  void backOnWeek() {
    setState(() {
      date = date.subtract(const Duration(days: 7));
    });
  }

  void nextOnWeek() {
    setState(() {
      date = date.add(const Duration(days: 7));
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final period =
        "${date.startOfWeek.day} - ${date.endOfWeek.day} ${DateFormat("MMMM y", s.localeName).format(date.endOfWeek)}";

    return Padding(
      padding: const .all(16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: .circular(12),
        ),
        child: Padding(
          padding: const .all(16),
          child: Column(
            spacing: 8,
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          s.weeklyExpense,
                          style: const TextStyle(
                            fontWeight: .bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          s.fromDate(period),
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: backOnWeek,
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),
                  IconButton(
                    onPressed: nextOnWeek,
                    icon: const Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),

              BlocSelector<ExpenseBloc, ExpenseState, List<GroupedExpense>>(
                selector: (state) => state.getGroupedExpenseByDate(date),
                builder: (_, data) => ScatterStatistics(expenses: data),
              ),

              BlocSelector<ExpenseBloc, ExpenseState, List<GroupedExpense>>(
                selector: (state) => state.getGroupedExpenseByDate(date),
                builder: (_, data) {
                  return ScatterExpensesList(expenses: data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
