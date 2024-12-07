import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget kCircularProgressIndicator({
//  Android Values
  double? value,
  Color? backgroundColor,
  Animation<Color>? valueColor,
  double strokeWidth = 4.0,

//  IOS values
  bool animating = true,
  double radius = 14,
}) {
  return Platform.isAndroid
      ? CircularProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
          strokeWidth: strokeWidth,
        )
      : CupertinoActivityIndicator(
          animating: animating,
          radius: radius,
        );
}
