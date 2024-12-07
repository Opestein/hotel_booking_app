import 'package:hotel_booking_app/setup.dart';
import 'package:hotel_booking_app/src/values/options.dart';
import 'package:hotel_booking_app/src/values/themes.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/app_translations.dart';
import 'package:hotel_booking_app/src/application.dart';
import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/home.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';

import 'src/singleton_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var env = Env.staging;
  await globalSetup(env);
  SingletonData.singletonData.initApiBaseURL('https://google.serper.dev');
  SingletonData.singletonData
      .initApiKey('68ebae0550c6350c55d7d7d69bec05816e98d7de');

  AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
  SettingOptions options = SettingOptions(
    appTranslationsDelegate: AppTranslationsDelegate(
        newLocale: application.supportedLocales().first),
    notification: false,
    theme: kLightHotelBookingTheme,
    darkTheme: kDarkHotelBookingTheme,
    hotelBookingThemeMode:
        kAllHotelBookingThemeModeValues.elementAt(appSettings.themeModeIndex),
    timeDilation: timeDilation,
    platform: defaultTargetPlatform,
  );

  var configuredApp = HotelBookingApp(
    options: options,
    child: HotelBookingHome(),
  );

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(configuredApp),
  );

  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // ).then(
  //   (_) => runApp(
  //     DevicePreview(
  //       enabled: !kReleaseMode,
  //       builder: (context) => configuredApp, // Wrap your app
  //     ),
  //   ),
  // );
}
