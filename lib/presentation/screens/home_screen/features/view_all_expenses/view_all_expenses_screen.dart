import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '/data/models/expense/expense.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/presentation/screens/home_screen/widgets/today_expenses.dart';
import '/utils/constants.dart';
import '/utils/extensions.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';

class ViewAllExpensesScreen extends StatefulWidget {
  const ViewAllExpensesScreen({super.key});

  @override
  State<ViewAllExpensesScreen> createState() => _ViewAllExpensesScreenState();
}

class _ViewAllExpensesScreenState extends State<ViewAllExpensesScreen> {
  late final DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat('d MMMM y');
  }

  @override
  void dispose() {
    GetIt.I<HomeBloc>().add(const ClearMonthFilterEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final filteredDayExpenses = state.filteredDayExpenses;

          return CustomScrollView(
            slivers: [
              ViewAllExpensesAppBar(
                selectedMonth: state.monthFilter,
                spendsOnSelectedMonth: state.spendsOnSelectedMonth,
                onMonthFilterUpdate: (month) {
                  context.read<HomeBloc>().add(FilterMonthEvent(month));
                },
              ),
              const ViewAllExpensesSectionTitle(),
              if (filteredDayExpenses.isEmpty)
                const ViewAllExpensesEmptyState()
              else
                ViewAllExpensesList(
                  dayExpenses: filteredDayExpenses,
                  dateFormat: _dateFormat,
                ),
            ],
          );
        },
      ),
    );
  }
}

class ViewAllExpensesAppBar extends StatelessWidget {
  final DateTime selectedMonth;
  final double spendsOnSelectedMonth;
  final void Function(DateTime) onMonthFilterUpdate;

  const ViewAllExpensesAppBar({
    super.key,
    required this.selectedMonth,
    required this.spendsOnSelectedMonth,
    required this.onMonthFilterUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.secondary,
      title: const Text(
        AppStrings.monthlyExpenses,
        style: AppTextStyles.headerStyle,
      ),
      pinned: true,
      floating: true,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.monthFilterHeight),
        child: MonthFilter(
          selectedMonth: selectedMonth,
          spendsOnSelectedMonth: spendsOnSelectedMonth,
          onUpdate: onMonthFilterUpdate,
        ),
      ),
    );
  }
}

class ViewAllExpensesSectionTitle extends StatelessWidget {
  const ViewAllExpensesSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: Text(
          AppStrings.recentExpenses,
          style: AppTextStyles.sectionTitleStyle,
        ),
      ),
    );
  }
}

class ViewAllExpensesEmptyState extends StatelessWidget {
  const ViewAllExpensesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: SizedBox(
          width: AppDimensions.emptyStateImageSize,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppDimensions.emptyStateImageRadius,
            ),
            child: Image.network(
              AppAssets.emptyStateImage,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: AppColors.grey,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ViewAllExpensesList extends StatelessWidget {
  final List<DayExpense> dayExpenses;
  final DateFormat dateFormat;

  const ViewAllExpensesList({
    super.key,
    required this.dayExpenses,
    required this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: dayExpenses.length,
      itemBuilder: (context, index) {
        final day = dayExpenses[index];
        return ViewAllExpensesDayItem(
          day: day,
          dateFormat: dateFormat,
          animationDelay: index * 50,
        );
      },
    );
  }
}

class ViewAllExpensesDayItem extends StatelessWidget {
  final DayExpense day;
  final DateFormat dateFormat;
  final int animationDelay;

  const ViewAllExpensesDayItem({
    super.key,
    required this.day,
    required this.dateFormat,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final title = day.date.isToday
        ? AppStrings.today
        : day.date.isYesterday
        ? AppStrings.yesterday
        : dateFormat.format(day.date);

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.smallPadding,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.dateLabelStyle),
          ...day.dayExpenses.map(
            (expense) => AnimatedExpenseItem(
              expense: expense,
              delay: Duration(milliseconds: animationDelay),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedExpenseItem extends StatefulWidget {
  final Expense expense;
  final Duration delay;

  const AnimatedExpenseItem({
    super.key,
    required this.expense,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedExpenseItem> createState() => _AnimatedExpenseItemState();
}

class _AnimatedExpenseItemState extends State<AnimatedExpenseItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scheduleAnimation();
  }

  void _scheduleAnimation() {
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleExpense(expense: widget.expense),
    );
  }
}

class MonthFilter extends StatelessWidget {
  final void Function(DateTime)? onUpdate;
  final DateTime selectedMonth;
  final double spendsOnSelectedMonth;

  const MonthFilter({
    super.key,
    required this.selectedMonth,
    required this.spendsOnSelectedMonth,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.defaultPadding,
        right: AppDimensions.defaultPadding,
        left: AppDimensions.defaultPadding,
      ),
      child: Material(
        borderRadius: .circular(AppDimensions.cornerRadius16),
        color: AppColors.primary,
        child: Padding(
          padding: const .all(AppDimensions.defaultPadding),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.smallPadding,
                  children: [
                    const Text(
                      AppStrings.spendThisMonth,
                      style: AppTextStyles.monthFilterTitleStyle,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        key: ValueKey(spendsOnSelectedMonth),
                        '${spendsOnSelectedMonth.toStringAsFixed(2)} Br',
                        style: AppTextStyles.monthFilterAmountStyle,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTapDown: (details) async {
                  AppBottomSheet.showDatePicker(
                    context: context,
                    onDateTimeChanged: (date) {
                      onUpdate?.call(date);
                    },
                    mode: .monthYear,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.smallPadding,
                  crossAxisAlignment: .end,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        key: ValueKey(selectedMonth.millisecondsSinceEpoch),
                        DateFormat('MMMM').format(selectedMonth),
                        style: AppTextStyles.monthFilterTitleStyle,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.onPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
