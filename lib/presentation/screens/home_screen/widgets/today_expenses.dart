import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/data/models/expense/expense.dart';
import '/utils/svgs/svg.dart';
import '/utils/widgets/app_text_button.dart';
import '../bloc/home_bloc.dart';

class TodayExpenses extends StatelessWidget {
  const TodayExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Padding(
        padding: const .symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 8,
          crossAxisAlignment: .center,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                const Text(
                  "Today's Expenses",
                  style: TextStyle(fontWeight: .bold),
                ),
                AppTextButton(
                  text: 'View all',
                  onPressed: () async {
                    context.pushNamed('view_all_expenses');
                  },
                ),
              ],
            ),
            if (state.todayExpenses.isNotEmpty)
              ...state.todayExpenses.map(
                (el) => SingleExpense(expense: el, onPressed: () {}),
              ),
            if (state.todayExpenses.isEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Nothing to show(',
                style: TextStyle(fontSize: 18, fontWeight: .bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SingleExpense extends StatelessWidget {
  final Expense expense;
  final void Function()? onPressed;

  const SingleExpense({super.key, required this.expense, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(16);

    return InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: colorScheme.onPrimary,
        ),
        padding: const .all(16),
        child: Row(
          spacing: 16,
          children: [
            Svg(
              expense.category.iconAsset,
              size: 36,
              color: expense.category.color,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    expense.category.name,
                    style: const TextStyle(fontWeight: .bold, fontSize: 16),
                  ),
                  Text(
                    DateFormat.jm('ru_RU').format(expense.datetime),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '- ${expense.formattedPrice} Br',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
