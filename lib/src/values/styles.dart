/*
*  styles.dart
*  Buenro
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro]. All rights reserved.
    */

import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/dialog/loading_dialog.dart';
import 'package:hotel_booking_app/src/values/colors.dart';
import 'package:hotel_booking_app/src/values/radii.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';


class CustomClearButton extends StatelessWidget {
  const CustomClearButton();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: Radii.k6pxRadius, color: theme.primaryColor),
      child: Icon(
        Icons.clear,
        color: theme.scaffoldBackgroundColor,
        size: 18,
      ),
    );
  }
}

showLoader({BuildContext? context}) {
  context = context ??
      SingletonData.singletonData.navigationKey.currentState!.overlay!.context;
  ThemeData theme = Theme.of(context);
  final bool isDark = theme.brightness == Brightness.dark;

  showDialog(
    context: context,
    useRootNavigator: true,
    barrierColor: isDark ? Colors.black54 : Colors.white54,
    builder: (context) => const LoadingDialog(),
    barrierDismissible: kDebugMode,
  );
}

closeLoader({BuildContext? context}) {
  context = context ??
      SingletonData.singletonData.navigationKey.currentState!.overlay!.context;

  Navigator.of(
      SingletonData
          .singletonData.navigationKey.currentState!.overlay!.context,
      rootNavigator: true)
      .pop();
}
