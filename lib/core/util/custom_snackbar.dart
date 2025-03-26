import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/theme/sizing.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showSnackBar(String message, bool isError, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? AppPalette.errorColor : AppPalette.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: Sizing.getScreenHeight(context) * 0.02,
          right: 20,
          left: 20,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
