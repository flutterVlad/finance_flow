import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 20, color: AppColors.onSurface),
      titleMedium: TextStyle(fontSize: 16, color: AppColors.onSecondary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.onSecondary),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.onPrimary,
      contentPadding: const .symmetric(horizontal: 16, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: .circular(16),
        borderSide: .none,
      ),
    ),
    scaffoldBackgroundColor: AppColors.secondary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.onPrimary,
      unselectedLabelColor: AppColors.onPrimary,
      indicator: BoxDecoration(
        borderRadius: .circular(30),
        color: AppColors.primary500.withValues(alpha: 0.5),
      ),
      indicatorSize: .tab,
      tabAlignment: .center,
      splashBorderRadius: .circular(30),
      dividerColor: Colors.transparent,
    ),
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme(
      brightness: .light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

abstract class AppColors {
  static const Color primary = Color(0xff2677ec);
  static const Color primary500 = Color(0xffc7dcfa);
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xffedecfd);
  static const Color onSecondary = Color(0xff1c1c2c);
  static const Color error = Color(0xffba1a1a);
  static const Color onError = Colors.white;
  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xff262635);
  static const Color grey = Color.fromARGB(255, 145, 145, 145);
  static const Color lightGrey = Color.fromARGB(255, 199, 199, 199);
}
