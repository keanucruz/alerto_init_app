import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 33, 22, 54),
    appBarTheme: const AppBarTheme(color: AppPalette.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _border(AppPalette.borderColor),
      focusedBorder: _border(AppPalette.primaryColor),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppPalette.backgroundColor,
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 243, 195, 91),
    appBarTheme: const AppBarTheme(
      color: AppPalette.primaryColor,
      iconTheme: IconThemeData(color: AppPalette.primaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _border(AppPalette.borderColor),
      focusedBorder: _border(AppPalette.primaryColor),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppPalette.whiteColor,
          displayColor: AppPalette.whiteColor,
        ),
  );
}
