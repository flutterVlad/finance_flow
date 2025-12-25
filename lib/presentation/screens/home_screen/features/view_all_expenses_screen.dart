import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/presentation/screens/home_screen/widgets/today_expenses.dart';
import '/utils/extensions.dart';
import '/utils/theme.dart';
import '/utils/widgets/app_bottom_sheet.dart';

class ViewAllExpensesScreen extends StatefulWidget {
  const ViewAllExpensesScreen({super.key});

  @override
  State<ViewAllExpensesScreen> createState() => _ViewAllExpensesScreenState();
}

class _ViewAllExpensesScreenState extends State<ViewAllExpensesScreen> {
  final bloc = GetIt.I<HomeBloc>();

  @override
  void dispose() {
    bloc.add(const ClearMonthFilterEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final List<DayExpense> filteredExpenses = state.dayExpenses
              .where((e) => e.date.month == state.monthFilter.month)
              .toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.secondary,
                title: const Text(
                  'Monthly expenses',
                  style: TextStyle(fontWeight: .bold, fontSize: 18),
                ),
                pinned: true,
                floating: true,
                surfaceTintColor: Colors.transparent,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(110),
                  child: MonthFilter(
                    selectedMonth: state.monthFilter,
                    onUpdate: (month) {
                      bloc.add(FilterMonthEvent(month));
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: .all(16),
                  child: Text(
                    'Recent Expenses',
                    style: TextStyle(fontSize: 16, fontWeight: .bold),
                  ),
                ),
              ),
              if (filteredExpenses.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: SizedBox(
                      width: 200,

                      child: ClipRRect(
                        borderRadius: .circular(16),
                        child: Image.network(
                          'https://img.freepik.com/premium-vector/nothing-rubber-stamp-seal-vector_140916-33117.jpg?semt=ais_hybrid&w=740&q=80',
                          fit: .cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ...filteredExpenses.map((day) {
                final title = day.date.isToday
                    ? 'Today'
                    : day.date.isYesterday
                    ? 'Yesterday'
                    : DateFormat('d MMMM y').format(day.date);

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 8,
                      mainAxisSize: .min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                        ...day.dayExpenses.map((expense) {
                          return SingleExpense(expense: expense);
                        }),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class MonthFilter extends StatelessWidget {
  final void Function(DateTime)? onUpdate;

  final DateTime selectedMonth;

  const MonthFilter({super.key, required this.selectedMonth, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Padding(
        padding: const .only(top: 16, right: 16, left: 16),
        child: Material(
          borderRadius: .circular(16),
          color: AppColors.primary,
          child: Padding(
            padding: const .all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    spacing: 12,
                    children: [
                      const Text(
                        'Spend this month',
                        style: TextStyle(color: AppColors.onPrimary),
                      ),
                      Text(
                        '${state.spendsOnCurrentMonth.toStringAsFixed(2)} Br',
                        style: const TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) async {
                    AppBottomSheet.showDatePicker(context, (date) {
                      onUpdate?.call(date);
                    }, mode: .monthYear);
                  },
                  child: Row(
                    mainAxisSize: .min,
                    spacing: 8,
                    children: [
                      Text(
                        DateFormat('MMMM').format(selectedMonth),
                        style: const TextStyle(color: AppColors.onPrimary),
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
      ),
    );
  }
}
