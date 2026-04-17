import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/data/models/expense/expense.dart';
import '/l10n/app_localizations.dart';
import '/presentation/screens/wallet_screen/helpers/scatter_helpers.dart';
import '/utils/extensions.dart';
import 'text_dot_painter.dart';

class ScatterStatistics extends StatelessWidget {
  const ScatterStatistics({
    super.key,
    required this.expenses,
    this.aspectRatio = 1.5,
  });
  final List<GroupedExpense> expenses;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (context, constrains) {
          final field = Field(
            constrains.maxWidth / ExpenseDataTransformer.fieldSize,
            constrains.maxHeight / ExpenseDataTransformer.fieldSize,
          );

          return ScatterChart(
            _scatterData(
              context,
              ExpenseDataTransformer.transform((expenses, field)),
            ),
          );
        },
      ),
    );
  }

  ScatterChartData _scatterData(
    BuildContext context,
    List<ExpenseScatterData> expenses,
  ) {
    return ScatterChartData(
      scatterSpots: expenses
          .map((e) => _CustomScatterSpot(expenseData: e))
          .toList(),
      minX: 0,
      maxX: 20,
      minY: 0,
      maxY: 20,
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      scatterTouchData: ScatterTouchData(
        enabled: true,
        touchTooltipData: ScatterTouchTooltipData(
          tooltipBorderRadius: .circular(12),
          getTooltipColor: (touchedSpot) =>
              touchedSpot.dotPainter.mainColor.withValues(alpha: 1),
          getTooltipItems: (ScatterSpot scatterSpot) {
            final amount = (scatterSpot as _CustomScatterSpot)
                .expenseData
                .amount
                .toCleanString();
            final category = scatterSpot.expenseData.category;
            final textColor = category.color!.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white;

            return ScatterTooltipItem(
              '${category.name}\n$amount ${S.of(context).byn}',
              textStyle: TextStyle(color: textColor),
            );
          },
        ),
      ),
    );
  }
}

class _CustomScatterSpot extends ScatterSpot {
  _CustomScatterSpot({required this.expenseData})
    : super(
        expenseData.x,
        expenseData.y,
        dotPainter: _createPainter(expenseData),
      );
  final ExpenseScatterData expenseData;

  static FlDotPainter _createPainter(ExpenseScatterData expense) {
    return TextDotPainter(
      radius: expense.radius,
      color: expense.category.color ?? Colors.grey,
      text: expense.formattedPercentage,
      strokeWidth: 2,
      strokeColor: expense.category.color ?? Colors.grey,
    );
  }
}
