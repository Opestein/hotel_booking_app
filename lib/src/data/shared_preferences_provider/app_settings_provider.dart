import 'dart:convert';

import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/model/hotel/hotel_list_response.dart';
import 'package:hotel_booking_app/src/model/hotel/login_response.dart';
import 'package:hotel_booking_app/src/model/saved_locale.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';

class AppSettingsProvider {
  Future<AppSettings> markAppTourViewed() async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.hasViewedAppTour = true;
    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> _saveAppSettings(AppSettings appSettings) async {
    (await SingletonData.singletonData.preferences).setString(
        'hotelBooking_app_settings', json.encode(appSettings.toMap()));

    return appSettings;
  }

  Future<AppSettings> fetchAppSettings() async {
    AppSettings appSettings = AppSettings(hotelResponse: HotelResponse());
    String? settingsData = (await SingletonData.singletonData.preferences)
        .getString('hotelBooking_app_settings');

    if (settingsData != null && settingsData.isNotEmpty) {
      appSettings = AppSettings.fromJson(
          Map<String, dynamic>.from(json.decode(settingsData)));
    }

    return appSettings;
  }

  Future<AppSettings> saveLoginDetails(HotelResponse hotelResponse) async {
    AppSettings appSettings = await fetchAppSettings();

    appSettings.hotelResponse = hotelResponse;

    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> setThemeMode(int themeModeIndex) async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.themeModeIndex = themeModeIndex;
    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> setLanguageLocale(SavedLocale locale) async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.locale = locale;
    return await _saveAppSettings(appSettings);
  }

  Future<AppSettings> addToFavorite(Place place) async {
    AppSettings appSettings = await fetchAppSettings();

    var cidList = appSettings.hotelResponse.cidList ?? [];
    cidList.add(place);

    appSettings.hotelResponse.cidList = cidList;

    return _saveAppSettings(appSettings);
  }

  Future<AppSettings> removeFromFavorite(String cid) async {
    AppSettings appSettings = await fetchAppSettings();

    var cidList = appSettings.hotelResponse.cidList ?? [];
    cidList.removeWhere((element) => element.cid == cid);

    appSettings.hotelResponse.cidList = cidList;

    return _saveAppSettings(appSettings);
  }

  Future<AppSettings> clearAllFavorites() async {
    AppSettings appSettings = await fetchAppSettings();
    appSettings.hotelResponse.cidList = [];

    return _saveAppSettings(appSettings);
  }


}

final appSettingsProvider = AppSettingsProvider();
