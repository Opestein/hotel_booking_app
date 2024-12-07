import 'package:hotel_booking_app/src/data/shared_preferences_provider/app_settings_provider.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/model/hotel/hotel_list_response.dart';
import 'package:hotel_booking_app/src/model/hotel/login_response.dart';
import 'package:hotel_booking_app/src/model/saved_locale.dart';

class AppSettingsRepository {
  Future<AppSettings> fetchAppSettings() async =>
      appSettingsProvider.fetchAppSettings();

  Future<AppSettings> markAppTourViewed() async =>
      appSettingsProvider.markAppTourViewed();

  Future<AppSettings> setThemeMode(int themeModeIndex) async =>
      appSettingsProvider.setThemeMode(themeModeIndex);

  Future<AppSettings> setLanguageLocale(SavedLocale locale) async =>
      appSettingsProvider.setLanguageLocale(locale);

  Future<AppSettings> addToFavorite(Place place) async =>
      appSettingsProvider.addToFavorite(place);

  Future<AppSettings> removeFromFavorite(String cid) async =>
      appSettingsProvider.removeFromFavorite(cid);

  Future<AppSettings> clearAllFavorites() async =>
      appSettingsProvider.clearAllFavorites();

  Future<AppSettings> saveLoginDetails(HotelResponse loginResponse) async =>
      appSettingsProvider.saveLoginDetails(loginResponse);
}

final appSettingsRepository = AppSettingsRepository();
