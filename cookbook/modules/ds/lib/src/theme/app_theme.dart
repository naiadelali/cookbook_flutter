import 'package:ds/ds.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData get lightTheme {
    AppColor.brightness = Brightness.light;

    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColor.primary.main,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColor.primary.main,
      secondary: AppColor.secondary.main,
      error: AppColor.danger.main,
      tertiary: AppColor.neutral.main,
      surface: AppColor.surface.defaults,
    );

    return ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      colorScheme: colorScheme,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColor.surface.defaults,
      ),
      appBarTheme: const AppBarTheme(elevation: 0.0),
    );
  }

  static ThemeData get darkTheme {
    AppColor.brightness = Brightness.dark;

    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: AppColor.primary.main,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColor.primary.main,
      secondary: AppColor.secondary.main,
      error: AppColor.danger.main,
      tertiary: AppColor.neutral.main,
      surface: AppColor.surface.defaults,
    );

    return ThemeData(
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColor.surface.defaults,
      ),
      appBarTheme: const AppBarTheme(elevation: 0.0),
    );
  }
}
