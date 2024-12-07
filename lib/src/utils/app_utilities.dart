import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hotel_booking_app/src/app.dart';
import 'package:url_launcher/url_launcher.dart';

double responsiveWidth(context, double width) {
  double blockHorizontal = MediaQuery.sizeOf(context).width / 100;
  double actualWidth = width * blockHorizontal;

  return actualWidth;
}

double responsiveHeight(context, double height) {
  double blockVertical = MediaQuery.sizeOf(context).height / 100;
  double actualHeight = height * blockVertical;

  return actualHeight;
}

double safeAreaWidth(context, double width) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);

  double safeAreaHorizontal =
      _mediaQueryData.padding.left + _mediaQueryData.padding.right;

  double safeAreaBlockHorizontal =
      (_mediaQueryData.size.width - safeAreaHorizontal) / 100;
  double actualWidth = width * safeAreaBlockHorizontal;

  return actualWidth;
}

double safeAreaHeight(context, double height) {
  MediaQueryData _mediaQueryData = MediaQuery.of(context);

  double safeAreaVertical =
      _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

  double safeAreaBlockVertical =
      (_mediaQueryData.size.height - safeAreaVertical) / 100;
  double actualHeight = height * safeAreaBlockVertical;

  return actualHeight;
}

double scaledHeight(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.sizeOf(context).height / 800);
}

double scaledWidth(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.sizeOf(context).width / 375);
}

double _singleUnit = 0;
double _scaleFactor = 0;
const noOfUnits = 480.0;

_setSingleUnit(context) {
  _singleUnit = MediaQuery.sizeOf(context).width;
  _scaleFactor = MediaQuery.of(context).textScaleFactor;
}

double textFontSize(context, double size) {
  double _scaleFactor = MediaQuery.of(context).textScaleFactor;
  return (size) / _scaleFactor;
}

//fontSize using textScaleFactor
double singleTextUnit(BuildContext context, double size) {
  _setSingleUnit(context);
  return (size) / _scaleFactor;
}

List<String> get alphabetList => [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

String randomString(int stringLength) {
  const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < stringLength; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}

const _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const _shortMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec'
];

const _shortDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

String getUrlToUse(String url) {
  return url.replaceAll('url', replacementUrlA!);
}

String getApiKeyToUse(String url) {
  return url.replaceAll('key', replacementApiKey!);
}

String getPaymentPublicKeyToUse(String url) {
  return url.replaceAll('paymentKey', replacementPaymentPublicKey!);
}

int getDayOfMonth(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return date.day;
}

String getDayOfWeek(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return _days[date.weekday - 1];
}

String getMonthOfYear(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return _months[date.month - 1];
}

String getBlogDate(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('MMMM dd, yyyy').format(date);
}

String getDayDDmm(int dateValue) {
  //Thu, 09 May
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return '${_shortDays[date.weekday - 1]}, ${beautifyDay(date.day)} ${_shortMonths[date.month - 1]}';
}

DateTime getCurrentDate(String dateValue) {
  var date = DateFormat('yyyy-MM-dd')
      .parse(dateValue.replaceAll('T00:00:00.000Z', ''));
  return date;
}

String get12Hour(DateTime dateValue) {
  var date = DateFormat.jm().format(dateValue);
  return date;
}

String beautifyDay(int day) {
  if (day < 10)
    return '0$day';
  else
    return '$day';
}

int nextDay(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  date.add(Duration(days: 1));
  return date.millisecondsSinceEpoch;
  ;
}

String getLongDate(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('EEE, MMM d, yyyy').format(date);
}

String getLongDateB(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('EEE, d MMM yyyy').format(date);
}

String getLongDateC(String? dateValue) {
  if ((dateValue ?? '').isEmpty) return '';
  var date = DateTime.parse(dateValue ?? '');

  return DateFormat('dd MMM yyyy').format(date);
}

String getLongDateD(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('EEE, d MMM yyyy HH:mm:ss').format(date);
}

String getLongDateE(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('EEE, d MMM yyyy').format(date);
}

String getLongDateF(String? dateValue) {
  if (dateValue == null || dateValue.isEmpty) return '';
  var date = DateTime.parse(dateValue);
  return DateFormat('dd MMMM yyyy').format(date);
}

String getYear(String? dateValue) {
  if (dateValue == null || dateValue.isEmpty) return '';
  var date = DateTime.parse(dateValue);
  return DateFormat('yyyy').format(date);
}

String getMonthDate(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('yyyy MMM, dd').format(date);
}

String get24hrsFromString(String dateValue) {
  var date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateValue);
  return get24hrs(date.millisecondsSinceEpoch);
}

String get24hrs(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('HH:mm:ss').format(date);
}

String getDayOnly(String? dateValue) {
  if ((dateValue ?? '').isEmpty) return '';

  var date = DateTime.parse(dateValue ?? '');
  return DateFormat('dd').format(date);
}

String getDay(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('dd:').format(date);
}

/// Checks if two DateTime objects are the same month.
/// Returns `false` if either of them is null.
bool isSameMonth(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month;
}

String getMonthYear(String? dateValue) {
  if (dateValue == null) return '';
  var date = DateTime.parse(dateValue);
  return DateFormat('MMM yyyy').format(date);
}

String getDuration(String original) {
  var values = original.split(':');
  if (values[0].contains('.')) {
    var subValues = values[0].split('.');
    values[0] =
        ((int.parse(subValues[0]) * 24) + int.parse(subValues[1])).toString();
  }
  return '${values[0]}h ${values[1]}m';
}

String simpleDateA(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('yyyy-MM-dd').format(date);
}

String? simpleDateB(String? dateValue) {
  var date = DateTime.tryParse(dateValue ?? '');

  if (date == null) {
    return null;
  }

  return DateFormat('dd/MM/yy').format(date);
}

String simpleDateC(String? dateValue) {
  if (dateValue == null) {
    return 'yyyy-MMM-dd HH:mm:ss';
  }

  var date = DateTime.parse(dateValue);
  return DateFormat('yyyy-MMM-dd HH:mm:ss').format(date);
}

String simpleDateD(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('MMM dd, yyyy').format(date);
}

String timeWithAMorPM(String dateValue) {
  var date = DateTime.parse(dateValue);
  return DateFormat('hh:mma').format(date);
}

String getLongDayDateFromString(String dateValue) {
  var date =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateValue.replaceAll('T', ' '));
  return getLongDayDate(date.millisecondsSinceEpoch);
}

String getLongDayDate(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('EEE, d MMM yyyy').format(date);
}

String getLongDay(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('EEEE, d MMMM, yyyy').format(date);
}

String getSubmitDate(int dateValue) {
  var date = DateTime.fromMillisecondsSinceEpoch(dateValue);
  return DateFormat('MM/dd/yyyy').format(date);
}

String formattedMoneyCrypto(double value) {
  //This function truncates the last digit as
  // it rounds it up for normal format
  int maxLength = 8;
  if (value.toString().contains('.') &&
      value.toString().split('.').length == 2) {
    var split = value.toString().split('.');
    if (split.elementAt(1).length > maxLength) {
      String value =
          '${split.first}.${split.elementAt(1).substring(0, maxLength)}';
      // debugPrint('format crypto $value');
      return NumberFormat('#,##0.#########')
          .format(double.tryParse(value) ?? 0.0);
    }
  }
  return NumberFormat('#,##0.########').format(value);
}

String formattedMoneyFiat(double value) {
  //This function truncates the last digit as
  // it rounds it up for normal format
  int maxLength = 2;
  if (value.toString().contains('.') &&
      value.toString().split('.').length == 2) {
    var split = value.toString().split('.');
    if (split.elementAt(1).length > maxLength) {
      String value =
          '${split.first}.${split.elementAt(1).substring(0, maxLength)}';
      // debugPrint('format crypto $value');
      return NumberFormat('#,##0.###').format(double.tryParse(value) ?? 0.0);
    }
  }
  return NumberFormat('#,##0.##').format(value);
}

String formatted(double value) {
  return NumberFormat('#,###').format(value);
}

String numberCompact(num value) {
  return NumberFormat.compact().format(value);
}

///This use [currency_icons] library
String getCurrencyIconPath(String currencyName) {
  return 'icons/currency/$currencyName.png';
}

DateTime getTenYearsFromDateTime(DateTime dateTime) {
  //Adds ten years and a month to the passed DateTime,
  //Setting the day to zero returns the previous month's last day
  DateTime tenYearsFromDateTime =
      DateTime(dateTime.year + 10, dateTime.month + 1, 0);
  return tenYearsFromDateTime;
}

Future<Uint8List> createFileFromString(String base64Encoded) async {
  Uint8List bytes = base64.decode(base64Encoded);

  return bytes;
}

String convertFileToString(File file) {
  String convertedFile = base64Encode(file.readAsBytesSync());

  return convertedFile;
}

String greetWithTime() {
  if (DateTime.now().hour < 12) {
    return 'Good morning ';
  } else if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
    return 'Good afternoon ';
  } else if (DateTime.now().hour >= 18 && DateTime.now().hour <= 24) {
    return 'Good evening ';
  } else {
    return 'Hi ';
  }
}

Future<File?> getImageFileFromAssets({required String fullFilePath}) async {
  if (fullFilePath.isEmpty) {
    return null;
  }

  final byteData = await rootBundle.load(fullFilePath);

  final file = File('${(await getTemporaryDirectory()).path}/$fullFilePath');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future writeUintToFile(Uint8List uint8list) async {
// convert uint to byteData
//  ByteData.view(bytes.buffer);

//  final buffer = data.buffer;

  final tempDir = await getApplicationDocumentsDirectory();
//  final file = await new File('${tempDir.path}/image.jpg').create();

  return File('${tempDir.path}/hotelBooking_profile.jpg')
      .writeAsBytes(uint8list);
}

//Future<File> _getImageFromGallery(BuildContext context) async {
//  File image = await ImagePicker.pickImage(source: ImageSource.gallery);
//  return image;
//}

//Future<File> _getCroppedImage(File image) async {
//  Future<File> _getCroppedImage(File image) async {
//    File croppedFile = await ImageCropper.cropImage(
//      sourcePath: image.path,
//      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//      androidUiSettings: AndroidUiSettings(
//          toolbarTitle: 'Crop Photo',
//          toolbarColor: AppColors.ternaryElement,
//          statusBarColor: AppColors.ternaryElement),
//    );
//
//    return croppedFile;
//  }
//}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String timeLeft(DateTime updatedDate) {
  int apiTime = 0;
  String time = '';

  if (updatedDate != null) {
    int differenceDays = DateTime.now().difference(updatedDate).inDays;

    apiTime = DateTime.now().difference(updatedDate).inMilliseconds;

    if (differenceDays > 14) {
      time = '${(differenceDays ~/ 7).toString} weeks ago';
    } else if (differenceDays == 0) {
      time = getDay(apiTime).toString().toString().replaceFirst(':', 'day ago');
    } else {
      time =
          getDay(apiTime).toString().toString().replaceFirst(':', 'days ago');
    }

    return time;
  } else {
    time = '0 day ago';
  }

  return ': ' + time;
}

String naira = '₦';
String dollar = '\$';

String camelCase(String input) {
  if (input == null) {
    return '';
  }
  if (input.length < 2) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

//DateTime lastDayOfMonth() {
//  var now =  DateTime.now();
//
//// Find the last day of the month.
//  var lastDayDateTime = (now.month < 12)
//      ?  DateTime(now.year, now.month + 1, 0)
//      :  DateTime(now.year + 1, 1, 0);
//
////  Find beginning of next month
////  var beginningNextMonth = (now.month < 12) ? new DateTime(now.year, now.month + 1, 1) :  DateTime(now.year + 1, 1, 1);
//
//
//  return lastDayDateTime;
//}

String lastDayOfMonth(int month) {
  var now = DateTime.now();

// Find the last day of the month.
  var lastDayDateTime = (now.month < 12)
      ? DateTime(now.year, now.month + month, 0)
      : DateTime(now.year + 1, month, 0);

//  Find beginning of next month
//  var beginningNextMonth = (now.month < 12) ? new DateTime(now.year, now.month + 1, 1) :  DateTime(now.year + 1, 1, 1);

  return getLongDateE(lastDayDateTime.toIso8601String());
}

String withdrawThriceAYear(int month) {
  var now = DateTime.now();

// Find the last day of the month.
  var date = DateTime(now.year, month, 0);

//  Find beginning of next month
//  var beginningNextMonth = (now.month < 12) ? new DateTime(now.year, now.month + 1, 1) : new DateTime(now.year + 1, 1, 1);

  return getLongDateE(date.toIso8601String());
}

Future<Color> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);
  return paletteGenerator.dominantColor!.color;
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    String newText = NumberFormat("#,##0.##").format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

String initial(String value) {
  String initial = '-';

  var list = value.split(' ');
  if (list.length > 1) {
    String firstText = list.elementAt(0);
    String secondText = list.elementAt(1);
    initial = firstText.substring(0, 1) +
        (secondText.isNotEmpty ? secondText.substring(0, 1) : '');
  } else {
    initial = value.substring(0, 1);
  }

  return initial;
}

String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return "$minutesStr:$secondsStr";
  }

  return "$hoursStr:$minutesStr:$secondsStr";
}

Future routeToPage(
    {required Widget child, String? routeName, BuildContext? context}) async {
  return await Navigator.push(
    context ?? SingletonData.singletonData.navigationKey.currentState!.context,
    MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(name: routeName),
    ),
  );
}

printData(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

ScrollStartNotification convertScrollListenerToScrollNotification(
    {required BuildContext context,
    required ScrollController scrollController}) {
  return ScrollStartNotification(
      context: context,
      metrics: FixedScrollMetrics(
          minScrollExtent: scrollController.position.minScrollExtent,
          maxScrollExtent: scrollController.position.maxScrollExtent,
          pixels: scrollController.position.pixels,
          viewportDimension: scrollController.position.viewportDimension,
          axisDirection: scrollController.position.axisDirection,
          devicePixelRatio: View.of(context).devicePixelRatio));
}

ScrollStartNotification convertNotificationListenerToScrollNotification(
    {required BuildContext context, required ScrollNotification notification}) {
  return ScrollStartNotification(
      context: context,
      metrics: FixedScrollMetrics(
          minScrollExtent: notification.metrics.minScrollExtent,
          maxScrollExtent: notification.metrics.maxScrollExtent,
          pixels: notification.metrics.pixels,
          viewportDimension: notification.metrics.viewportDimension,
          axisDirection: notification.metrics.axisDirection,
          devicePixelRatio: View.of(context).devicePixelRatio));
}
