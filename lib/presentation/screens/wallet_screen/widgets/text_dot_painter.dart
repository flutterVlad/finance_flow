import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TextDotPainter extends FlDotPainter {
  final double radius;
  final Color color;
  final String text;
  final TextStyle textStyle;
  final double strokeWidth;
  final Color strokeColor;

  const TextDotPainter({
    required this.radius,
    required this.color,
    required this.text,
    required this.strokeWidth,
    required this.strokeColor,
    this.textStyle = const TextStyle(color: Colors.white),
  });

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    if (strokeWidth != 0.0 && strokeColor.a != 0.0) {
      canvas.drawCircle(
        offsetInCanvas,
        radius + (strokeWidth / 2),
        Paint()
          ..color = strokeColor.withValues(alpha: 0.8)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
    }
    canvas.drawCircle(
      offsetInCanvas,
      radius,
      Paint()
        ..color = color.withValues(alpha: 0.4)
        ..style = PaintingStyle.fill,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color.withValues(
            red: color.r - 0.2,
            green: color.g - 0.2,
            blue: color.b - 0.2,
          ),
          fontSize: radius * 0.4,
          fontWeight: .bold,
        ),
      ),
      textAlign: .center,
      textDirection: .ltr,
    )..layout();

    textPainter.paint(
      canvas,
      offsetInCanvas - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  @override
  Size getSize(FlSpot spot) {
    return Size.fromRadius(radius + strokeWidth);
  }

  TextDotPainter _lerp(TextDotPainter a, TextDotPainter b, double t) =>
      TextDotPainter(
        color: Color.lerp(a.color, b.color, t)!,
        radius: lerpDouble(a.radius, b.radius, t) ?? 0,
        strokeColor: Color.lerp(a.strokeColor, b.strokeColor, t)!,
        strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t)!,
        text: '',
      );

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is! TextDotPainter || b is! TextDotPainter) {
      return b;
    }
    return _lerp(a, b, t);
  }

  @override
  Color get mainColor => color;

  @override
  List<Object?> get props => [radius, color, text, textStyle];
}
