import 'dart:math';

import '/data/models/category/category.dart';
import '/data/models/expense/expense.dart';

class ExpenseDataTransformer {
  static const double fieldSize = 20.0;

  static List<ExpenseScatterData> transform(
    (List<GroupedExpense>, Field) inputData,
  ) {
    if (inputData.$1.isEmpty) return [];
    final data = inputData.$1;

    final totalAmount = inputData.$1.fold(0.0, (a, b) => a + b.amount);
    data.sort((a, b) => b.amount.compareTo(a.amount));

    final radii = _calculateRadii(data, field: inputData.$2);

    final positions = _generatePositions(radii, field: inputData.$2);

    return List.generate(data.length, (i) {
      final entry = data[i];
      final percentage = (entry.amount / totalAmount) * 100;
      return ExpenseScatterData(
        x: positions[i].$1,
        y: positions[i].$2,
        radius: radii[i],
        percentage: percentage,
        amount: entry.amount,
        category: entry.category,
      );
    });
  }

  static List<double> _calculateRadii(
    List<GroupedExpense> data, {
    required Field field,
  }) {
    final count = data.length;
    final maxAmount = data.first.amount;

    final fieldWidthPx = fieldSize * field.width;
    final fieldHeightPx = fieldSize * field.height;
    final shortSide = min(fieldWidthPx, fieldHeightPx);

    final fieldAreaPx = fieldWidthPx * fieldHeightPx;
    // final fillFactor = (0.65 / (1.0 + count * 0.04)).clamp(0.25, 0.4);
    final fillFactor = ((0.75 + 0.5 * (count - 5)) / 5).clamp(0.15, 0.40);
    final avgRadius = sqrt(fieldAreaPx * fillFactor / (count * pi));
    final maxByCount = sqrt(fieldAreaPx / (count * pi)) * 1.1;
    final maxAllowed = shortSide / 2 * 0.85;

    final maxR = (avgRadius * 1.8).clamp(0.0, min(maxAllowed, maxByCount));
    final minR = (avgRadius * 0.4).clamp(0.0, maxR * 0.5);

    return data.map((e) {
      final t = sqrt(e.amount / maxAmount);
      return minR + t * (maxR - minR);
    }).toList();
  }

  /// Позиционирование: большие радиусы — ближе к центру,
  /// маленькие — по краям. Без пересечений через force-directed.
  static List<(double, double)> _generatePositions(
    List<double> radii, {
    required Field field,
  }) {
    final count = radii.length;
    if (count == 0) return [];
    if (count == 1) return [(fieldSize / 2, fieldSize / 2)];

    const center = fieldSize / 2;
    const minPos = 0.5;
    const maxPos = fieldSize - 0.5;

    // Радиус в координатных единицах по каждой оси отдельно
    final radiiX = radii.map((r) => r / field.width).toList();
    final radiiY = radii.map((r) => r / field.height).toList();

    final positions = List.generate(count, (i) {
      if (i == 0) return (center, center);
      final angle = 2 * pi * i / count + pi / 6;
      final ringRadius = (i / count) * (fieldSize / 2 - radiiX[i] - 0.5);
      return (
        (center + cos(angle) * ringRadius).clamp(minPos, maxPos),
        (center + sin(angle) * ringRadius).clamp(minPos, maxPos),
      );
    });

    final iterations = (200 + count * 15).clamp(250, 800);

    for (int iter = 0; iter < iterations; iter++) {
      final learningRate = 0.4 * (1.0 - iter / iterations);
      double totalDisplacement = 0.0;

      for (int i = 0; i < count; i++) {
        double fx = 0.0;
        double fy = 0.0;
        final (xi, yi) = positions[i];

        for (int j = 0; j < count; j++) {
          if (i == j) continue;
          final (xj, yj) = positions[j];
          final dx = xi - xj;
          final dy = yi - yj;

          // Расстояние с учётом разного масштаба осей:
          // переводим в пиксели для корректного сравнения
          final dxPx = dx * field.width;
          final dyPx = dy * field.height;
          final distPx = sqrt(
            dxPx * dxPx + dyPx * dyPx,
          ).clamp(0.001, double.infinity);
          final minDistPx = radii[i] + radii[j] + 6.0; // зазор в пикселях

          if (distPx < minDistPx) {
            final overlap = (minDistPx - distPx) / minDistPx;
            final force = overlap * overlap * 12;
            // Возвращаем силу обратно в координатные единицы
            fx += (dx / max(distPx / field.width, 0.001)) * force;
            fy += (dy / max(distPx / field.height, 0.001)) * force;
          }
        }

        final centerWeight = 1.0 - (i / max(count - 1, 1)) * 0.75;
        fx += (center - xi) * 0.06 * centerWeight;
        fy += (center - yi) * 0.06 * centerWeight;

        // Границы с учётом радиуса по каждой оси
        final marginX = radiiX[i] + 0.2;
        final marginY = radiiY[i] + 0.2;
        if (xi < minPos + marginX) fx += 0.8 / max(xi - minPos, 0.01);
        if (xi > maxPos - marginX) fx -= 0.8 / max(maxPos - xi, 0.01);
        if (yi < minPos + marginY) fy += 0.8 / max(yi - minPos, 0.01);
        if (yi > maxPos - marginY) fy -= 0.8 / max(maxPos - yi, 0.01);

        final nx = (xi + fx * learningRate).clamp(
          minPos + marginX,
          maxPos - marginX,
        );
        final ny = (yi + fy * learningRate).clamp(
          minPos + marginY,
          maxPos - marginY,
        );

        totalDisplacement += sqrt(pow(nx - xi, 2) + pow(ny - yi, 2));
        positions[i] = (nx, ny);
      }

      if (totalDisplacement < 0.0001) break;
    }

    return positions;
  }
}

class ExpenseScatterData {
  const ExpenseScatterData({
    required this.x,
    required this.y,
    required this.radius,
    required this.percentage,
    required this.amount,
    required this.category,
  });
  final double x;
  final double y;
  final double radius;
  final double percentage;
  final double amount;
  final Category category;

  String get formattedPercentage => '${percentage.round()}%';
}

class Field {
  const Field(this.width, this.height);
  final double width;
  final double height;

  @override
  bool operator ==(Object other) =>
      other is Field && other.width == width && other.height == height;

  @override
  int get hashCode => Object.hash(width, height);
}
