/*
*  router.dart
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 Buenro. All rights reserved.
    */

import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:flutter/material.dart';

Future<dynamic> pushToNextScreen(
    {BuildContext? context,
    required Widget child,
    bool fullscreenDialog = false,
    bool rootNavigator = false,
    bool useMaterialRouter = false,
    String? name,
    Object? arguments,
    //  GTM
    String? eventName,
    String? eventType}) {
  context = context ??
      SingletonData.singletonData.navigationKey.currentState!.context;

  if (eventName != null &&
      eventName.isNotEmpty &&
      eventType != null &&
      eventType.isNotEmpty) {
    // logEventToPartners(eventName: eventName, type: eventType);
  }

  return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute(
          builder: (context) => child,
          fullscreenDialog: fullscreenDialog,
          settings: RouteSettings(name: name, arguments: arguments)));
}

pop({BuildContext? context, bool rootNavigator = false, resultToSendBack}) {
  context = context ??
      SingletonData.singletonData.navigationKey.currentState!.context;
  // SingletonData.singletonData.gtm.push(
  //   'Close Page ',
  //   parameters: {
  //     'action': 'popPage',
  //   },
  // );
  Navigator.of(context, rootNavigator: rootNavigator).pop(resultToSendBack);
}
