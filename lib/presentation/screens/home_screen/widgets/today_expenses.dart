import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/data/models/expense/expense.dart';
import '/l10n/app_localizations.dart';
import '/presentation/bloc/expense/expense_bloc.dart';
import '/utils/extensions.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_dialog.dart';
import '/utils/widgets/app_text_button.dart';

class TodayExpenses extends StatelessWidget {
  const TodayExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) => Padding(
        padding: const .symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  s.todayExpenses,
                  style: const TextStyle(fontWeight: .bold, fontSize: 16),
                ),
                AppTextButton(
                  text: s.viewAll,
                  onPressed: () async {
                    context.pushNamed('view_all_expenses');
                  },
                ),
              ],
            ),
            if (state.todayExpenses.isNotEmpty)
              ...state.todayExpenses.map(
                (el) => SingleExpense(
                  expense: el,
                  isDismissible: true,
                  onDelete: () {
                    context.read<ExpenseBloc>().add(.deleteExpense(el));
                  },
                  onEdit: () {
                    context.pushNamed('add_transaction', extra: el);
                  },
                ),
              ),
            if (state.todayExpenses.isEmpty) ...[
              const SizedBox(height: 20),
              Text(
                s.nothingToShow,
                style: const TextStyle(fontSize: 18, fontWeight: .bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SingleExpense extends StatelessWidget {
  const SingleExpense({
    super.key,
    required this.expense,
    this.isDismissible = false,
    this.onPressed,
    this.onDelete,
    this.onEdit,
  });
  final Expense expense;
  final bool isDismissible;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(16);
    final s = S.of(context);

    final child = Material(
      color: colorScheme.onPrimary,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Padding(
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
                  spacing: 4,
                  children: [
                    Text(
                      expense.name.capitalize(),
                      style: const TextStyle(fontWeight: .bold, fontSize: 16),
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    RichText(
                      text: TextSpan(
                        text: expense.category.name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: .bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                ' - ${DateFormat.jm(s.localeName).format(expense.datetime)}',
                            style: const TextStyle(fontWeight: .normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${expense.isIncome ? '+' : '-'} ${expense.formattedPrice} ${s.byn}',
                style: TextStyle(
                  color: expense.isIncome
                      ? Colors.green
                      : Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!isDismissible) {
      return child;
    }

    final DismissDirection dismissDirection;

    if (onEdit != null && onDelete != null) {
      dismissDirection = .horizontal;
    } else if (onEdit != null) {
      dismissDirection = .startToEnd;
    } else if (onDelete != null) {
      dismissDirection = .endToStart;
    } else {
      dismissDirection = .none;
    }

    return Dismissible(
      key: ValueKey(expense.id.uuid),
      background: _Background.second(borderRadius: borderRadius),
      secondaryBackground: _Background(borderRadius: borderRadius),
      confirmDismiss: (direction) async {
        if (direction == .endToStart) {
          return await AppDialog.confirmDelete(
            context: context,
            title: s.confirmDelete(expense.name),
          );
        } else if (direction == .startToEnd) {
          onEdit?.call();
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == .endToStart) onDelete?.call();
      },
      direction: dismissDirection,
      child: child,
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({required this.borderRadius}) : direction = .endToStart;

  const _Background.second({required this.borderRadius})
    : direction = .startToEnd;

  final BorderRadius borderRadius;
  final DismissDirection direction;

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Alignment alignment;
    final IconData icon;
    final String text;

    if (direction == .endToStart) {
      bgColor = Colors.red.shade600;
      alignment = .centerRight;
      icon = Icons.delete_outline_rounded;
      text = 'Delete';
    } else {
      bgColor = AppColors.primary;
      alignment = .centerLeft;
      icon = Icons.edit;
      text = 'Edit';
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const .symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: .min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 11,
                  fontWeight: .w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
