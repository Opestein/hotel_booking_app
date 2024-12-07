import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_pie_chart.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_utils.dart';

class CustomLegendOptions {
  final bool showLegends;
  final bool showLegendsInRow;
  final TextStyle legendTextStyle;
  final BoxShape legendShape;
  final CustomLegendPosition legendPosition;

  const CustomLegendOptions({
    this.showLegends = true,
    this.showLegendsInRow = false,
    this.legendTextStyle = defaultCustomLegendStyle,
    this.legendShape = BoxShape.circle,
    this.legendPosition = CustomLegendPosition.right,
  });
}
