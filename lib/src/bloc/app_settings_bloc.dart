import 'package:hotel_booking_app/src/data/shared_preferences_provider/app_settings_repo.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/model/hotel/hotel_list_response.dart';
import 'package:hotel_booking_app/src/model/hotel/login_response.dart';
import 'package:hotel_booking_app/src/model/saved_locale.dart';
import 'package:rxdart/rxdart.dart';

class _AppSettingsBloc {
  final BehaviorSubject<AppSettings> _appSettingsStreamController =
      BehaviorSubject<AppSettings>();

  BehaviorSubject<AppSettings> get appSettings => _appSettingsStreamController;

  void dispose() => _appSettingsStreamController.close();

  Future<AppSettings> fetchAppSettings() async {
    AppSettings appSettings = await appSettingsRepository.fetchAppSettings();
    _appSettingsStreamController.sink.add(appSettings);

    return appSettings;
  }

  markAppTourViewed() async {
    var saved = await appSettingsRepository.markAppTourViewed();
    _appSettingsStreamController.sink.add(saved);
  }

  Future<AppSettings> saveLoginDetails(HotelResponse loginResponse) async {
    var result = await appSettingsRepository.saveLoginDetails(loginResponse);
    _appSettingsStreamController.sink.add(result);
    return result;
  }

  setThemeMode(int themeModeIndex) async {
    var saved = await appSettingsRepository.setThemeMode(themeModeIndex);
    _appSettingsStreamController.sink.add(saved);
  }

  setLanguageLocale(SavedLocale locale) async {
    var saved = await appSettingsRepository.setLanguageLocale(locale);
    _appSettingsStreamController.sink.add(saved);
  }

  addToFavorite(Place place) async {
    var saved = await appSettingsRepository.addToFavorite(place);

    _appSettingsStreamController.sink.add(saved);
  }

  removeFromFavorite(String cid) async {
    var saved = await appSettingsRepository.removeFromFavorite(cid);

    _appSettingsStreamController.sink.add(saved);
  }

  clearAllFavorites() async {
    var saved = await appSettingsRepository.clearAllFavorites();

    _appSettingsStreamController.sink.add(saved);
  }
}

final appSettingsBloc = _AppSettingsBloc();
