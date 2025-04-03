import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static TextTheme _createTextTheme(TextTheme base, Color textColor) {
    return GoogleFonts.montserratTextTheme(base).copyWith(
      displayLarge: GoogleFonts.montserrat(
        textStyle: base.displayLarge,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: GoogleFonts.montserrat(
        textStyle: base.displayMedium,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: GoogleFonts.montserrat(
        textStyle: base.displaySmall,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.montserrat(
        textStyle: base.headlineLarge,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.montserrat(
        textStyle: base.headlineMedium,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.montserrat(
        textStyle: base.headlineSmall,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      titleLarge: GoogleFonts.montserrat(
        textStyle: base.titleLarge,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.montserrat(
        textStyle: base.titleMedium,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: GoogleFonts.montserrat(
        textStyle: base.titleSmall,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.montserrat(
        textStyle: base.bodyLarge,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.montserrat(
        textStyle: base.bodyMedium,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: GoogleFonts.montserrat(
        textStyle: base.bodySmall,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      labelLarge: GoogleFonts.montserrat(
        textStyle: base.labelLarge,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: GoogleFonts.montserrat(
        textStyle: base.labelMedium,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: GoogleFonts.montserrat(
        textStyle: base.labelSmall,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

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
    textTheme:
        _createTextTheme(ThemeData.dark().textTheme, AppPalette.whiteColor),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: AppPalette.primaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      enabledBorder: _border(AppPalette.borderColor),
      focusedBorder: _border(AppPalette.primaryColor),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    textTheme:
        _createTextTheme(ThemeData.dark().textTheme, AppPalette.whiteColor),
  );
}
