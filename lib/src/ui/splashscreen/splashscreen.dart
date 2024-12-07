/*
*  SplashPage
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro]. All rights reserved.
    */

import 'package:hotel_booking_app/src/mixin/splash_helper.dart';
import 'package:hotel_booking_app/src/utils/ui_functions.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:hotel_booking_app/src/values/values.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splashPage';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashHelper {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkFirstScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localise.hotelApp,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: kBoldWeight),
            ),
            16.height,
            Center(
              child: kCircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
