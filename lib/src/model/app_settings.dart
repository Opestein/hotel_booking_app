import 'package:hotel_booking_app/src/model/hotel/login_response.dart';
import 'package:hotel_booking_app/src/model/saved_locale.dart';

class AppSettings {
  bool hasViewedAppTour;
  SavedLocale? locale;
  int themeModeIndex;
  HotelResponse hotelResponse;
  bool biometricsEnabled;

  AppSettings({
    this.hasViewedAppTour = false,
    this.themeModeIndex = 2,
    this.locale,
    required this.hotelResponse,
    this.biometricsEnabled = false,
  });

  factory AppSettings.fromJson(Map<String, dynamic> data) => AppSettings(
        hasViewedAppTour: data['hasViewedAppTour'] ?? false,
        themeModeIndex: data['themeModeIndex'] ?? 0,
        locale: data['locale'] is String
            ? SavedLocale(localeName: data['locale'])
            : data['locale'] != null
                ? SavedLocale.fromJson(data['locale'])
                : SavedLocale(),
        hotelResponse: HotelResponse.fromJson(data['hotelResponse']),
        biometricsEnabled: data['biometricsEnabled'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'hasViewedAppTour': hasViewedAppTour,
        'locale': locale?.toJson(),
        'themeModeIndex': themeModeIndex,
        'hotelResponse': hotelResponse.toJson(),
        'biometricsEnabled': biometricsEnabled,
      };
}
