import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/model/system_input_type.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/values/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_booking_app/src/ui/splashscreen/splashscreen.dart';
import 'package:hotel_booking_app/src/values/values.dart';

class HotelBookingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = HotelBookingApp.of(context);

    SettingOptions options = provider.options!;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          SystemInputType.hide;
        }
      },
      onVerticalDragUpdate: (e) {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          SystemInputType.hide;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        child: MaterialApp(
            navigatorKey: SingletonData.singletonData.navigationKey,
            themeMode: options.hotelBookingThemeMode!.themeMode,
            darkTheme: options.darkTheme!.data.copyWith(),
            theme: options.theme!.data.copyWith(),
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) =>
                    const Scaffold(body: Center(child: Text('No Item Found'))),
              );
            },
            title: 'Hotel Booking',
            color: AppColors.primaryButton,
            debugShowCheckedModeBanner: kDebugMode,
            navigatorObservers: [
              SingletonData.singletonData.routeObserver,
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // AppFlowyEditorLocalizations.delegate,
            ],
            locale: options.hotelBookingLanguage?.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              // debugPrint('deviceLocale: $deviceLocale');
              for (var locale in supportedLocales) {
                // debugPrint('supportedLocales: ${locale.countryCode} ${locale.languageCode}');
                if (deviceLocale != null &&
                    locale.languageCode == deviceLocale.languageCode) {
                  // if(locale.countryCode == deviceLocale.countryCode)
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            home: SplashPage()),
      ),
    );
  }
}
