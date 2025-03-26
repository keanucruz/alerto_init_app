import 'package:flutter/material.dart';

class Sizing {
  static const paddingSize = EdgeInsets.all(18.0);

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double responsiveHeight(BuildContext context, double percentage) {
    return getScreenHeight(context) * percentage;
  }

  static double responsiveWidth(BuildContext context, double percentage) {
    return getScreenWidth(context) * percentage;
  }
}
