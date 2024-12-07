import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_utils.dart';

class CustomChartValuesOptions {
  final bool showChartValueBackground;
  final int decimalPlaces;
  final bool showChartValuesInPercentage;
  final bool showChartValues;
  final bool showChartValuesOutside;
  final Color? chartValueBackgroundColor;
  final TextStyle chartValueStyle;

  const CustomChartValuesOptions({
    this.showChartValueBackground = true,
    this.decimalPlaces = 1,
    this.chartValueBackgroundColor,
    this.showChartValuesInPercentage = false,
    this.chartValueStyle = defaultCustomChartValueStyle,
    this.showChartValues = true,
    this.showChartValuesOutside = false,
  });
}
