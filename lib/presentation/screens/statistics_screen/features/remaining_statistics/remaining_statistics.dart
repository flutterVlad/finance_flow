import 'package:finance_flow/utils/svgs/svg.dart';
import 'package:finance_flow/utils/svgs/svgs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/category/category.dart';
import '/data/models/expense/expense.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
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
        final expenses = state.expenseOnCurrentMonth;

        final difference = state.balance - state.spendsOnCurrentMonth;
        final isAddEmpty = difference > 0;

        if (isAddEmpty) {
          expenses.add(
            Expense(
              category: Category.empty,
              datetime: DateTime.now(),
              price: difference,
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Padding(
            padding: const .all(16),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: PieChart(
                PieChartData(
                  startDegreeOffset: 90,
                  sectionsSpace: 1,
                  centerSpaceRadius: 60,
                  borderData: FlBorderData(
                    border: Border.all(width: 100, color: Colors.red),
                  ),
                  sections: expenses
                      .map(
                        (e) => _makeSectionData(
                          expense: e,
                          isTouched: expenses.indexOf(e) == touchedIndex,
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
                        touchedIndex =
                            response.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                ),
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
  }) {
    return PieChartSectionData(
      value: expense.price,
      color: expense.category.color,
      showTitle: isTouched,
      borderSide: BorderSide(width: isTouched ? 3 : 1),
      radius: 30,
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
        final incomeExpenses = state.incomeOnCurrentMonth;

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
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index + 1 == incomeExpenses.length + 1) {
                            return const _Element(elementName: 'income');
                          }
                          return _Element(expense: incomeExpenses[index]);
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: AppColors.grey.withValues(alpha: 0.5),
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

  const _Element({this.expense, this.elementName = ''});

  @override
  Widget build(BuildContext context) {
    if (expense != null) {
      return Row(
        spacing: 8,
        children: [
          Svg(expense!.category.iconAsset, color: AppColors.grey, size: 25),
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
      );
    }

    return Row(
      spacing: 8,
      children: [
        const Svg(Svgs.addRounded, color: AppColors.grey),
        Text('Add $elementName'),
      ],
    );
  }
}
