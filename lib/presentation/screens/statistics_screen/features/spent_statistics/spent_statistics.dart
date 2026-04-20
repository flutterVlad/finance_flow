import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/data/models/expense/expense.dart';
import '/l10n/app_localizations.dart';
import '/presentation/screens/home_screen/bloc/home_bloc.dart';
import '/utils/extensions.dart';
import '/utils/svgs/svg.dart';
import '/utils/theme.dart';
import '/utils/widgets/animated_text.dart';
import '../widgets/date_filter.dart';

class SpentStatistics extends StatelessWidget {
  const SpentStatistics({super.key});

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
    final centerSpaceRadius = MediaQuery.widthOf(context) / 5;
    final s = S.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final expenses = state.expenseOnSelectedMonth;

        final allSpends = state.spendsOnSelectedMonth;

        if (allSpends == 0) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const .all(16.0),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Center(child: Text(s.noDataInThisMonth)),
              ),
            ),
          );
        }

        final price = touchedIndex != -1
            ? expenses[touchedIndex].formattedAmount
            : allSpends.toCleanString();

        final title = touchedIndex != -1
            ? expenses[touchedIndex].category.name
            : s.allSpends;

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
                      children: [
                        AnimatedText(text: '$price ${s.byn}'),
                        AnimatedText(
                          text: title,
                          style: const TextStyle(
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
                              isTouched: expenses.indexOf(e) == touchedIndex,
                            ),
                          )
                          .toList(),
                      pieTouchData: PieTouchData(
                        enabled: true,
                        touchCallback: (event, response) {
                          if (event is! FlTapUpEvent) return;

                          if (response == null ||
                              response.touchedSection == null) {
                            setState(() => touchedIndex = -1);
                            return;
                          }

                          final tappedIndex =
                              response.touchedSection!.touchedSectionIndex;

                          if (tappedIndex == touchedIndex) {
                            setState(() => touchedIndex = -1);
                            return;
                          }

                          setState(() => touchedIndex = tappedIndex);
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
    required GroupedExpense expense,
    bool isTouched = false,
    double radius = 30,
  }) {
    return PieChartSectionData(
      value: expense.amount,
      color: expense.category.color,
      showTitle: false,
      borderSide: BorderSide(
        width: isTouched ? 2 : 0,
        color: expense.category.color!.darken(),
      ),
      radius: isTouched ? radius + 10 : radius,
      titleStyle: const TextStyle(color: AppColors.grey, fontSize: 12),
      title: '${expense.formattedAmount}\n${expense.category.name}',
      titlePositionPercentageOffset: 1.8,
    );
  }
}

class Income extends StatelessWidget {
  const Income({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => !const ListEquality().equals(
        prev.incomesOnSelectedMonth,
        curr.incomesOnSelectedMonth,
      ),
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
                        Text(
                          s.incomes,
                          style: const TextStyle(fontWeight: .bold),
                        ),
                        Text(
                          '${income.toCleanString()} ${s.byn}',
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
                              elementName: s.income,
                              onTap: () {
                                context.pushNamed(
                                  'add_transaction',
                                  extra: true,
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
  const _Element({this.expense, this.elementName = '', this.onTap});
  final Expense? expense;
  final String elementName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

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
                  '${expense!.formattedPrice} ${s.byn}',
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
          Text(s.addItem(elementName.toLowerCase())),
        ],
      ),
    );
  }
}
