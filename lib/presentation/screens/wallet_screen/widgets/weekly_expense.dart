import 'dart:math';

import 'package:finance_flow/presentation/screens/wallet_screen/widgets/scatter_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/extensions.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_text_button.dart';
import 'scatter_expenses_list.dart';

class WeeklyExpense extends StatelessWidget {
  const WeeklyExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const .all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: .circular(12),
            ),
            padding: const .all(16),
            child: Column(
              mainAxisSize: .min,
              mainAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        const Text(
                          'Weekly Expense',
                          style: TextStyle(fontWeight: .bold, fontSize: 16),
                        ),
                        Text(
                          'From ${DateTime.now().startOfWeek.day} - ${DateTime.now().endOfWeek.day} ${DateTime.now().endOfWeek.strMonthShort}, 2025',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    AppTextButton(
                      text: 'View Report',
                      onPressed: () {
                        GetIt.I<HomeBloc>().add(const InitHomeEvent());
                      },
                    ),
                  ],
                ),
                ScatterStatistics(currentWeekExpenses: state.curWeekExpenses),
                ScatterExpensesList(
                  expenses: state.comparedCurrentWeekExpenses,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
