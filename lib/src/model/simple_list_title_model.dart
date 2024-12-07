import 'package:flutter/material.dart';

class SimpleListTitleModel {
  final String? id, imageUri, title, extraTitle, content;
  String? subtitle, valueText;
  final Widget Function(BuildContext context, int index)? childBuilder;
  final DateTime? dateTime, startDate, endDate;
  bool isSelected;
  bool isEnabled;
  final Function()? onPressed;
  final dynamic datum;

  SimpleListTitleModel(
      {this.id,
      this.imageUri,
      this.childBuilder,
      this.title,
      this.subtitle,
      this.extraTitle,
      this.content,
      this.valueText,
      this.dateTime,
      this.startDate,
      this.endDate,
      this.isSelected = false,
      this.isEnabled = false,
      this.onPressed,
      this.datum});
}
