import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/values/languages.dart';
import 'package:hotel_booking_app/src/values/options.dart';
import 'package:hotel_booking_app/src/values/themes.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

const String isolateName = 'hotelBooking_firebase_background';

Future<void> globalSetup(Env env) async {
  SingletonData.singletonData.initEnv(env);
}

Future<SettingOptions> optionsSetup() async {
  AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
  SettingOptions options = SettingOptions(
    notification: false,
    hotelBookingLanguage: kAllHotelBookingLanguageValues.firstWhere(
        (element) =>
            element.locale.languageCode ==
            appSettings.locale?.localeName?.split('_').firstOrNull,
        orElse: () => kAllHotelBookingLanguageValues.firstWhere(
            (element) => element.locale.toString() == 'en_UK',
            orElse: () => kAllHotelBookingLanguageValues.first)),
    theme: kLightHotelBookingTheme,
    darkTheme: kDarkHotelBookingTheme,
    hotelBookingThemeMode:
        kAllHotelBookingThemeModeValues.elementAt(appSettings.themeModeIndex),
    timeDilation: timeDilation,
    platform: defaultTargetPlatform,
  );

  return options;
}
