import 'dart:ui';

import 'package:finance_flow/utils/svgs/svgs.dart';

extension DateTimeMonth on DateTime {
  String get strMonthShort => months[month - 1].substring(0, 3);

  String get strMonthLarge => months[month - 1];

  List<String> get months => const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  bool get isToday {
    final today = DateTime.now();

    return today.day == day && today.month == month && today.year == year;
  }

  bool get isYesterday {
    final today = DateTime.now();

    return today.day - 1 == day && today.month == month && today.year == year;
  }

  bool get isCurrentMonth {
    final today = DateTime.now();

    return today.month == month && today.year == year;
  }

  DateTime get startOfWeek {
    final today = DateTime.now();
    return today.subtract(Duration(days: today.weekday - 1));
  }

  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6));

  bool isSelectedMonth(DateTime date) =>
      date.month == month && date.year == year;
}

extension Json on Color {
  Map<String, dynamic> toJson() {
    return {
      'alpha': (a * 255.0).round().clamp(0, 255).toInt(),
      'red': (r * 255.0).round().clamp(0, 255).toInt(),
      'green': (g * 255.0).round().clamp(0, 255).toInt(),
      'blue': (b * 255.0).round().clamp(0, 255).toInt(),
    };
  }
}

abstract class ColorHelper {
  static Color? colorFromJson(Map<dynamic, dynamic>? json) {
    if (json == null) return null;
    final fixJson = Map<String, dynamic>.from(json);

    return Color.fromARGB(
      fixJson['alpha'] as int,
      fixJson['red'] as int,
      fixJson['green'] as int,
      fixJson['blue'] as int,
    );
  }

  static Map<String, dynamic>? colorToJson(Color? color) => color?.toJson();
}

abstract class SvgDataHelper {
  static SvgData svgDataFromJson(Map<dynamic, dynamic> json) {
    final fixJson = Map<String, dynamic>.from(json);

    return SvgData.fromJson(fixJson);
  }

  static Map<String, dynamic> svgDataToJson(SvgData svg) => svg.toJson();
}
