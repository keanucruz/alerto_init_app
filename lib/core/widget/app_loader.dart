import 'package:app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const GFLoader(
      type: GFLoaderType.circle,
      loaderColorOne: AppPalette.primaryColor,
      loaderColorTwo: AppPalette.whiteColor,
      loaderColorThree: AppPalette.primaryColor,
    );
  }
}
