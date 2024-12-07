import 'dart:async';

import 'package:hotel_booking_app/src/ui/home_screen/homescreen.dart';
import 'package:hotel_booking_app/src/values/router.dart';
import 'package:flutter/material.dart';

mixin class SplashHelper {
  Future checkFirstScreen(BuildContext context) async {
    Timer(const Duration(seconds: 2), () {
      _navigationHomePage();
    });
  }

  _navigationHomePage() {
    pushToNextScreen(child: HomePage(), name: HomePage.routeName);
  }
}
