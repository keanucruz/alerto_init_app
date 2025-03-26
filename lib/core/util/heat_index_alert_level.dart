import 'package:flutter/material.dart';

class HeatIndexAlertLevel {
  static String getHeatIndexWarning(double heatIndex) {
    if (heatIndex < 27) {
      return 'Not Hazardous';
    } else if (heatIndex >= 27 && heatIndex <= 32) {
      return 'Caution';
    } else if (heatIndex > 32 && heatIndex <= 41) {
      return 'Extreme Caution';
    } else if (heatIndex > 41 && heatIndex <= 51) {
      return 'Danger';
    } else {
      return 'Extreme Danger';
    }
  }

  static Color getHeatIndexColor(double heatIndex) {
    if (heatIndex < 27) {
      return Colors.green;
    } else if (heatIndex >= 27 && heatIndex <= 32) {
      return Colors.yellow.shade800;
    } else if (heatIndex > 32 && heatIndex <= 41) {
      return Colors.orange;
    } else if (heatIndex > 41 && heatIndex <= 51) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }
}
