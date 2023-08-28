import 'package:flutter/material.dart';
import 'package:of_will/application/styles/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    fontFamily: 'Nexa',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: AppStyles.mainShape,
    ),
    cardTheme: const CardTheme(
      shape: AppStyles.mainShape,
    ),
    listTileTheme: const ListTileThemeData(
      shape: AppStyles.mainShape,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.orange,
    fontFamily: 'Nexa',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 18,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: AppStyles.mainShape,
    ),
    cardTheme: const CardTheme(
      shape: AppStyles.mainShape,
    ),
    listTileTheme: const ListTileThemeData(
      shape: AppStyles.mainShape,
    ),
  );
}

extension ColorSchemeS on ColorScheme {
  Color get titleColor => brightness == Brightness.light
      ? const Color(0xFF1976D2)
      : const Color(0xFFFF9800);
}
