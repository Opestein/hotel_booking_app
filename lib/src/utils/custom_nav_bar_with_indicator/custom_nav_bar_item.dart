import 'package:flutter/material.dart';

class CustomNavigationBarItem {
  final Widget leadingWidget;
  final Widget? icon;
  final Color? backgroundColor;

  CustomNavigationBarItem(
      {this.icon, required this.leadingWidget, this.backgroundColor});
}
