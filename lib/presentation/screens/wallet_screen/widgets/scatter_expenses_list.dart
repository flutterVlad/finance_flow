import 'package:flutter/material.dart';

import '/data/models/expense/expense.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';

class ScatterExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ScatterExpensesList({super.key, this.expenses = const []});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: .zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: .circular(12),
          ),
          padding: const .all(8),
          child: Row(
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Svg(
                expense.category.iconAsset,
                size: 40,
                color: expense.category.color,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(expense.category.name),
                    Text(
                      expense.formattedPrice,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
