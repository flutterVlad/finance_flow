import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '/data/models/category/category.dart';
import '/data/models/expense/expense.dart';
import '/presentation/screens/actions_screen/features/add_transaction/bloc/transactions_cubit.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/svgs/svg.dart';
import '/utils/svgs/svgs.dart';
import '/utils/theme.dart';
import '../widgets/date_filter.dart';

class RemainingStatistics extends StatelessWidget {
  const RemainingStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return const CustomScrollView(
          slivers: [DateFilter(), Diagram(), Income()],
        );
      },
    );
  }
}

class Diagram extends StatefulWidget {
  const Diagram({super.key});

  @override
  State<Diagram> createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final expenses = state.expenseOnSelectedMonth;

        final difference =
            state.balanceOnSelectedMonth - state.spendsOnSelectedMonth;
        final isAddEmpty = difference > 0;

        final emptyExpense = Expense(
          id: UuidValue.fromString(const Uuid().v4()),
          category: Category.empty,
          datetime: DateTime.now(),
          price: difference,
        );

        if (isAddEmpty) expenses.add(emptyExpense);

        final centerSpaceRadius = MediaQuery.widthOf(context) / 5;

        return SliverToBoxAdapter(
          child: Padding(
            padding: const .all(16),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: Stack(
                fit: .expand,
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: touchedIndex != -1
                          ? [
                              Text(
                                '${expenses[touchedIndex].formattedPrice} Br',
                              ),
                              Text(
                                expenses[touchedIndex].category.name,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ]
                          : [
                              Text('${difference.toStringAsFixed(2)} Br'),
                              const Text(
                                'Left to spend',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                    ),
                  ),
                  PieChart(
                    PieChartData(
                      startDegreeOffset: 90,
                      sectionsSpace: 2,
                      centerSpaceRadius: centerSpaceRadius,
                      sections: expenses
                          .map(
                            (e) => _makeSectionData(
                              expense: e,
                              radius: centerSpaceRadius / 2.5,
                              isTouched:
                                  expenses.indexOf(e) == touchedIndex &&
                                  e != emptyExpense,
                            ),
                          )
                          .toList(),
                      pieTouchData: PieTouchData(
                        enabled: true,
                        touchCallback: (event, response) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                response == null ||
                                response.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            if (response.touchedSection!.touchedSectionIndex ==
                                    expenses.length - 1 &&
                                expenses.length != 1) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex =
                                response.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  PieChartSectionData _makeSectionData({
    required Expense expense,
    bool isTouched = false,
    double radius = 30,
  }) {
    return PieChartSectionData(
      value: expense.price,
      color: expense.category.color,
      showTitle: false,
      borderSide: BorderSide(width: isTouched ? 2 : 0),
      radius: radius,
      titleStyle: const TextStyle(color: AppColors.grey, fontSize: 12),
      title: '${expense.formattedPrice}\n${expense.category.name}',
      titlePositionPercentageOffset: 1.8,
    );
  }
}

class Income extends StatelessWidget {
  const Income({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final incomeExpenses = state.incomesOnSelectedMonth;

        final double income = incomeExpenses.fold(.0, (a, b) => a + b.price);

        return SliverToBoxAdapter(
          child: Padding(
            padding: const .all(16),
            child: Material(
              borderRadius: .circular(16),
              child: Padding(
                padding: const .all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        const Text(
                          'Income',
                          style: TextStyle(fontWeight: .bold),
                        ),
                        Text(
                          '${income.toStringAsFixed(2)} Br',
                          style: const TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const .symmetric(vertical: 8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: .zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index + 1 == incomeExpenses.length + 1) {
                            return _Element(
                              elementName: 'income',
                              onTap: () {
                                context.pushNamed(
                                  'add_transaction',
                                  extra: GetIt.I<TransactionsCubit>()
                                      .initIncomeTransaction,
                                );
                              },
                            );
                          }
                          return _Element(expense: incomeExpenses[index]);
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.grey.withValues(alpha: 0.5),
                          height: 20,
                          indent: 5,
                          endIndent: 5,
                        ),
                        itemCount: incomeExpenses.length + 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Element extends StatelessWidget {
  final Expense? expense;
  final String elementName;
  final void Function()? onTap;

  const _Element({this.expense, this.elementName = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    if (expense != null) {
      return GestureDetector(
        onTap: onTap,
        child: Row(
          spacing: 8,
          children: [
            Svg(expense!.category.iconAsset, color: AppColors.grey, size: 30),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(expense!.category.name),
                Text(
                  expense!.formattedPrice,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Row(
        spacing: 8,
        children: [
          const Svg(Svgs.addRounded, color: AppColors.grey, size: 30),
          Text('Add $elementName'),
        ],
      ),
    );
  }
}
