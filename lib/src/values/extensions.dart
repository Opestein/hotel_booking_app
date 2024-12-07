import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/values/values.dart';
import 'package:hotel_booking_app/src/utils/app_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations get localise =>
    SingletonData.singletonData.navigationKey.currentState!.context.localise;

HotelBookingAppState get injector =>
    SingletonData.singletonData.navigationKey.currentState!.context.injector;

ThemeData get theme =>
    SingletonData.singletonData.navigationKey.currentState!.context.theme;

BuildContext get appContext =>
    SingletonData.singletonData.navigationKey.currentState!.context;

extension CustonBuildContext on BuildContext? {
  AppLocalizations get localise => AppLocalizations.of(this!)!;

  HotelBookingAppState get injector => HotelBookingApp.of(this!);

  ThemeData get theme => Theme.of(this!);

  bool get isDarkTheme => theme.brightness == Brightness.dark;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this!);

  MediaQueryData get mediaQuery => MediaQuery.of(this!);

  NavigatorState get navigator => Navigator.of(this!);

  FocusScopeNode get focusScope => FocusScope.of(this!);

  ScaffoldState get scaffold => Scaffold.of(this!);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this!);

  ///Returns Colors
  Color? get accentText {
    var context =
        this ?? SingletonData.singletonData.navigationKey.currentContext!;

    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return isDark ? AppColors.accentDarkText : AppColors.accentText;
  }

  Color? get upTrendColor {
    var context =
        this ?? SingletonData.singletonData.navigationKey.currentContext!;

    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return isDark ? AppColors.upTrendColor : AppColors.upTrendColor;
  }

  Color? get downTrendColor {
    var context =
        this ?? SingletonData.singletonData.navigationKey.currentContext!;

    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return isDark ? AppColors.downTrendColor : AppColors.downTrendColor;
  }
}

extension CustomString on String? {
  ///Returns Strings
  bool get isNotNullAndIsNotEmpty {
    return (this ?? '').isNotEmpty;
  }

  String get toCamelCase {
    return camelCase(this ?? '');
  }

  String get ngnPhone {
    String phone = this ?? '';

    if (phone.startsWith('+234')) {
      phone = phone.substring(4);
    } else if (phone.startsWith('234')) {
      phone = phone.substring(3);
    } else if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    phone = '234$phone';

    return phone;
  }

  String get addNumericPlural {
    return (this).toDouble > 1 ? 's' : '';
  }

  String get toCryptoValue {
    String money = (this).toDouble.toFormattedCryptoValue;

    return money;
  }

  String get toFiatValue {
    String money = (this).toDouble.toFormattedFiatValue;

    return money;
  }

  String get intoBracket {
    String value = (this != null && this!.isNotEmpty) ? '($this)' : '';

    return value;
  }

  String get outOfBracket {
    String value = (this ?? '');
    if (value.length > 1) {
      value = value.substring(1, value.length - 1);
    }

    return value;
  }

  String get removeTheAtAtTheBeginning {
    String value = this ?? '';
    return value.startsWith('@') ? value.substring(value.indexOf(' ')) : value;
  }

  String get initials {
    String value = (this ?? '').split(' ').length > 1
        ? '${(this ?? ' ')[0]}${(this ?? ' ')[1]}'
        : (this ?? '').isNotEmpty
            ? (this ?? '')[0]
            : (this ?? '');

    return value;
  }

  String get beautifyValue {
    String value = this ?? '';

    value = camelCase(value.replaceAll('_', ' '));
    return value;
  }

  String? get beautifyValueNullable {
    if (this == null) return null;
    String value = this ?? '';

    value = camelCase(value.replaceAll('_', ' '));
    return value;
  }

  ///Returns integers
  int get toInt {
    String money = (this ?? '0').replaceAll(',', '').trim();

    return int.tryParse(money) ?? 0;
  }

  ///Returns doubles
  double get toDouble {
    String money = (this ?? '0.0').replaceAll(',', '').trim();

    return double.tryParse(money) ?? 0.0;
  }

  String get removeUrlScheme {
    return (this ?? '')
        .replaceAll('http://', '')
        .replaceAll('https://', '')
        .replaceAll("www.", '');
  }
}

extension CustomNullableNum on num? {
  ///Returns boolean
  bool get isZero {
    num value = this ?? 0.0;

    return value == 0.0 || value == 0;
  }

  ///Returns boolean
  bool get isGreaterThanOne {
    num value = this ?? 1.0;

    return value > 1.0 || value > 1;
  }

  ///Returns boolean
  bool get isLesserThanOne {
    num value = this ?? 1.0;

    return value < 1.0 || value < 1;
  }

  ///Returns boolean
  bool get isGreaterThanZero {
    num value = this ?? 0.0;

    return value > 0.0 || value > 0;
  }

  ///Returns boolean
  bool get isGreaterOrEqualToZero {
    num value = this ?? 0.0;

    return value >= 0.0 || value >= 0;
  }

  ///Returns boolean
  bool get isLesserThanZero {
    num value = this ?? 0.0;

    return value < 0.0 || value < 0;
  }

  ///Returns boolean
  bool get isLesserOrEqualToZero {
    num value = this ?? 0.0;

    return value <= 0.0 || value <= 0;
  }

  ///Returns numbers
  num get toSafeValue {
    num value = this is int ? (this ?? 0) : (this ?? 0.0);
    return value;
  }

  ///Reduce large number to small with word at the end .e.g. 1,000,000 to 1M
  String get toCompactNumber {
    return numberCompact((this ?? 0.0).toDouble());
  }

  ///Returns Strings
  String get toFormattedCryptoValue {
    num value = this ?? 0.0;

    return formattedMoneyCrypto(value.toDouble());
  }

  String get toFormattedFiatValue {
    num value = this ?? 0.0;

    return formattedMoneyFiat(value.toDouble());
  }

  String get toChangeValue {
    num value = this ?? 0.0;

    return '${value.isNegative ? '' : "+"}${formattedMoneyFiat(value.toDouble())}';
  }

  ///Returns Colors
  Color get getTrendColorFromValue {
    if (this != null && this! > 0) {
      return AppColors.upTrendColor;
    } else if (this != null && this! < 0) {
      return AppColors.downTrendColor;
    } else {
      return AppColors.grey;
    }
  }

  ///Returns Widgets
  Widget get screenHeightInPercentSafeArea {
    var context = SingletonData.singletonData.navigationKey.currentContext!;

    return SizedBox(
      height: safeAreaHeight(context, (this ?? 0.0).toDouble()),
    );
  }

  Widget get screenWidthInPercentSafeArea {
    var context = SingletonData.singletonData.navigationKey.currentContext!;

    return SizedBox(
      width: safeAreaWidth(context, (this ?? 0.0).toDouble()),
    );
  }

  Widget get screenHeightInPercent {
    var context = SingletonData.singletonData.navigationKey.currentContext!;

    return SizedBox(
      height: responsiveHeight(context, (this ?? 0.0).toDouble()),
    );
  }

  Widget get screenWidthInPercent {
    var context = SingletonData.singletonData.navigationKey.currentContext!;

    return SizedBox(
      width: responsiveWidth(context, (this ?? 0.0).toDouble()),
    );
  }

  Widget get height {
    return SizedBox(
      height: (this ?? 0.0).toDouble(),
    );
  }

  Widget get width {
    return SizedBox(
      width: (this ?? 0.0).toDouble(),
    );
  }

  ///Returns Colors

  Color get trendColor {
    var value = this ?? 0;

    return value == 0
        ? AppColors.accentText
        : value.isNegative
            ? AppColors.downTrendColor
            : AppColors.upTrendColor;
  }

  ///  Returns Duration
  Duration get toMillisecondsDuration {
    return Duration(milliseconds: (this ?? 0.0).toInt());
  }
}

extension CustomDatetime on DateTime? {
  bool checkIsSameMonth(DateTime? newDateTime) {
    return isSameMonth(this, newDateTime);
  }
}

extension CustomDuration on Duration? {
  String get toTimeline {
    if (this != null) {
      var duration = this!;
      if (duration.inDays > 1) {
        return '${duration.inDays} days';
      } else if (duration.inDays == 1) {
        return '${duration.inDays} day';
      } else if (duration.inHours > 1) {
        return '${duration.inHours} hrs';
      } else if (duration.inHours == 1) {
        return '${duration.inHours} hr';
      } else if (duration.inMinutes > 1) {
        return '${duration.inMinutes} mins';
      } else if (duration.inMinutes == 1) {
        return '${duration.inMinutes} min';
      } else if (duration.inSeconds > 1) {
        return '${duration.inSeconds} secs';
      } else if (duration.inSeconds == 1) {
        return '${duration.inSeconds} sec';
      }
    }
    return '';
  }
}

extension CustomAppSettings on AppSettings? {
  Future<bool> get isLoggedIn async =>
      ((await appSettingsBloc.fetchAppSettings()).hotelResponse?.token ?? '')
          .isNotEmpty;
}
