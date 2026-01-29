import 'dart:math';

import 'package:finance_flow/utils/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/day_expenses/day_expenses.dart';
import '../bloc/home_bloc.dart';

class ExpenseAnalytics extends StatelessWidget {
  const ExpenseAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          child: Column(
            spacing: 16,
            crossAxisAlignment: .start,
            children: [
              const Text(
                'Expense Analytics',
                style: TextStyle(fontWeight: .bold),
              ),
              Chart(
                barColor: Theme.of(context).colorScheme.primary,
                touchedBarColor: Theme.of(context).colorScheme.primary,
                values: state.curWeekDayExpenses,
                maxWeekSpends: state.maxWeekSpends,
              ),
            ],
          ),
        );
      },
    );
  }
}

class Chart extends StatefulWidget {
  final Color barColor;
  final Color touchedBarColor;
  final Color barBackgroundColor;
  final List<DayExpense> values;
  final double maxWeekSpends;

  const Chart({
    super.key,
    this.barColor = Colors.blue,
    this.touchedBarColor = Colors.red,
    this.barBackgroundColor = AppColors.onSurface,
    this.values = const [],
    this.maxWeekSpends = 0,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        barChartData,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    double maxY = 20,
    bool isTouched = false,
    Color? barColor,
    double width = 18,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    const initMaxY = 20.0;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y * 1.05 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : null,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: max(maxY, initMaxY),
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [
                widget.barBackgroundColor.withValues(alpha: 0.1),
                widget.barBackgroundColor.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData>? get barGroups {
    final maxY = widget.maxWeekSpends * 1.2;

    return List.generate(7, (i) {
      double daySpend;
      if (widget.values.isNotEmpty) {
        daySpend = i < widget.values.length ? widget.values[i].daySpend : 0.0;
      } else {
        daySpend = 0;
      }

      return makeGroupData(
        i,
        daySpend,
        maxY: maxY,
        isTouched: i == touchedIndex,
      );
    });
  }

  BarChartData get barChartData => BarChartData(
    barTouchData: BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        tooltipBorderRadius: .circular(16),
        getTooltipColor: (_) => Colors.white,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            '${widget.values[groupIndex].formattedAllSpends} Br',
            const TextStyle(),
          );
        },
      ),
      touchCallback: (event, barTouchResponse) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            touchedIndex = -1;
            return;
          }
          touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
        });
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getTitles,
          reservedSize: 40,
        ),
      ),
    ),
    borderData: FlBorderData(show: false),
    barGroups: barGroups,
    gridData: const FlGridData(show: false),
    alignment: .spaceAround,
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 14);
    String text = switch (value.toInt()) {
      0 => 'Mon',
      1 => 'Tue',
      2 => 'Wed',
      3 => 'Thu',
      4 => 'Fri',
      5 => 'Sat',
      6 => 'Sun',
      _ => '',
    };
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }
}
