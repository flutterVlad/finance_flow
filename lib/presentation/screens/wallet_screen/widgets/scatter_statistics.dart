import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/data/models/category/category.dart';
import '/data/models/expense/expense.dart';
import 'text_dot_painter.dart';

class ScatterStatistics extends StatelessWidget {
  final List<Expense> currentWeekExpenses;
  final double aspectRatio;

  const ScatterStatistics({
    super.key,
    this.currentWeekExpenses = const [],
    this.aspectRatio = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final expenses = _ExpenseDataTransformer.transform(currentWeekExpenses);

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ScatterChart(_scatterData(expenses)),
    );
  }

  ScatterChartData _scatterData(List<_ExpenseScatterData> expenses) {
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
              touchedSpot.dotPainter.mainColor.withAlpha(200),
          getTooltipItems: (ScatterSpot scatterSpot) {
            return ScatterTooltipItem(
              (scatterSpot as _CustomScatterSpot).expenseData.formattedAmount,
            );
          },
        ),
      ),
    );
  }
}

class _CustomScatterSpot extends ScatterSpot {
  final _ExpenseScatterData expenseData;

  _CustomScatterSpot({required this.expenseData})
    : super(
        expenseData.x,
        expenseData.y,
        dotPainter: _createPainter(expenseData),
      );

  static FlDotPainter _createPainter(_ExpenseScatterData expense) {
    return TextDotPainter(
      radius: expense.radius,
      color: expense.category.color ?? Colors.grey,
      text: expense.formattedPercentage,
      strokeWidth: 2,
      strokeColor: expense.category.color ?? Colors.grey,
    );
  }
}

class _ExpenseScatterData {
  final double x;
  final double y;
  final double radius;
  final double percentage;
  final double amount;
  final Category category;

  const _ExpenseScatterData({
    required this.x,
    required this.y,
    required this.radius,
    required this.percentage,
    required this.amount,
    required this.category,
  });

  String get formattedAmount => '${amount.toStringAsFixed(2)} Br';

  String get formattedPercentage => '${percentage.round()}%';
}

class _ExpenseDataTransformer {
  static const double fieldSize = 20.0;

  static List<_ExpenseScatterData> transform(List<Expense> inputData) {
    if (inputData.isEmpty) return [];

    final groupedExpenses = <String, Expense>{};

    for (final expense in inputData) {
      if (groupedExpenses.keys.contains(expense.category.name)) {
        groupedExpenses[expense.category.name] = Expense(
          id: expense.id,
          category: expense.category,
          datetime: expense.datetime,
          price: expense.price + groupedExpenses[expense.category.name]!.price,
        );
      } else {
        groupedExpenses[expense.category.name] = expense;
      }
    }

    final data = groupedExpenses.values.toList();

    final totalAmount = data.fold(0.0, (sum, amount) => sum + amount.price);

    data.sort((a, b) => b.price.compareTo(a.price));

    final positions = _generateOptimalPositions(data.length);

    final result = <_ExpenseScatterData>[];

    for (int i = 0; i < data.length; i++) {
      final entry = data[i];
      final amount = entry.price;
      final percentage = (amount / totalAmount) * 100;

      // Радиус пропорционален проценту от максимальной суммы
      final maxAmount = data.first.price;
      final radius = fieldSize / 2 + (amount / maxAmount) * fieldSize * 1.5;

      final (x, y) = positions[i];

      result.add(
        _ExpenseScatterData(
          x: x,
          y: y,
          radius: radius,
          percentage: percentage,
          amount: amount,
          category: defaultCategories.firstWhere(
            (e) => e.name == entry.category.name,
          ),
        ),
      );
    }

    return result;
  }

  // Алгоритм для нахождения оптимальных позиций без пересечений
  static List<(double, double)> _generateOptimalPositions(int count) {
    if (count == 0) return [];
    if (count == 1) return [(fieldSize / 2, fieldSize / 2)];

    // Для 2-4 элементов используем симметричное расположение
    if (count <= 4) {
      return _generateSymmetricalPositions(count);
    }

    // Для большего количества используем алгоритм силы
    return _generateForceDirectedPositions(count);
  }

  // Симметричное расположение для малого количества элементов
  static List<(double, double)> _generateSymmetricalPositions(int count) {
    const center = fieldSize / 2;
    const centerless = fieldSize / 2.5;
    const centerfull = fieldSize / 1.5;

    switch (count) {
      case 1:
        return [(center, center)];
      case 2:
        return [(centerless, center), (centerfull, center)];
      case 3:
        return [
          (center, centerless),
          (centerless, centerfull),
          (centerfull, centerfull),
        ];
      case 4:
        return [
          (centerless, centerless),
          (centerfull, centerless),
          (centerless, centerfull),
          (centerfull, centerfull),
        ];
      default:
        return _generateForceDirectedPositions(count);
    }
  }

  // Алгоритм силы для оптимального расположения
  static List<(double, double)> _generateForceDirectedPositions(
    int count, {
    List<double> radii = const [],
  }) {
    const center = fieldSize / 2;
    const minPos = 1.0;
    const maxPos = fieldSize - 1;

    // Если переданы радиусы, используем их для расчета расстояний
    final useRadii = radii.isNotEmpty && radii.length == count;

    // Начальные позиции по кругу
    final positions = List.generate(count, (index) {
      final angle = 2 * pi * index / count;
      final startRadius = min(4.0, fieldSize / 4);
      return (
        center + cos(angle) * startRadius,
        center + sin(angle) * startRadius,
      );
    });

    // Итерации для минимизации пересечений
    for (int iteration = 0; iteration < 150; iteration++) {
      // Больше итераций
      double totalDisplacement = 0.0;

      for (int i = 0; i < count; i++) {
        double forceX = 0.0;
        double forceY = 0.0;

        final (xi, yi) = positions[i];
        final radiusI = useRadii ? radii[i] : 0.0;

        // Отталкивание от других точек с учетом радиусов
        for (int j = 0; j < count; j++) {
          if (i == j) continue;

          final (xj, yj) = positions[j];
          final radiusJ = useRadii ? radii[j] : 0.0;

          final dx = xi - xj;
          final dy = yi - yj;
          final distance = sqrt(dx * dx + dy * dy);

          // Минимальное расстояние с учетом радиусов
          final minDistance = useRadii
              ? (radiusI + radiusJ) *
                    0.7 // Коэффициент 0.7 для плотности
              : 4.0; // Базовое расстояние

          if (distance < minDistance) {
            // Сила отталкивания обратно пропорциональна расстоянию
            final force = (minDistance - distance) / distance;
            forceX += dx * force;
            forceY += dy * force;
          }
        }

        // Притяжение к центру (чтобы не улетали за границы)
        final centerDx = center - xi;
        final centerDy = center - yi;
        final centerDistance = sqrt(centerDx * centerDx + centerDy * centerDy);

        // Если слишком далеко от центра
        const attractionRadius = fieldSize / 3; // ~6.7
        if (centerDistance > attractionRadius) {
          final attractionForce = 0.05 * (centerDistance - attractionRadius);
          forceX += centerDx / centerDistance * attractionForce;
          forceY += centerDy / centerDistance * attractionForce;
        }

        // Отталкивание от границ
        const borderMargin = 3.0;
        if (xi < minPos + borderMargin) {
          forceX += 0.5 / (xi - minPos);
        } else if (xi > maxPos - borderMargin) {
          forceX -= 0.5 / (maxPos - xi);
        }

        if (yi < minPos + borderMargin) {
          forceY += 0.5 / (yi - minPos);
        } else if (yi > maxPos - borderMargin) {
          forceY -= 0.5 / (maxPos - yi);
        }

        // Обновляем позицию с уменьшающимся коэффициентом обучения
        final learningRate = 0.15 * (1 - iteration / 150.0);
        final newX = (xi + forceX * learningRate).clamp(minPos, maxPos);
        final newY = (yi + forceY * learningRate).clamp(minPos, maxPos);

        totalDisplacement += sqrt(pow(newX - xi, 2) + pow(newY - yi, 2));
        positions[i] = (newX, newY);
      }

      // Ранняя остановка если перемещения минимальны
      if (totalDisplacement < 0.001) break;
    }

    return positions;
  }
}
