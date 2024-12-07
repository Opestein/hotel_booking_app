import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:hotel_booking_app/src/data/server_provider/base_network_call_handler.dart';
import 'package:hotel_booking_app/src/utils/operation.dart';

class HotelProvider extends BaseNetworkCallHandler {
  Future<Operation> getHotels(
      {String engine = '',
      String query = '',
      String country = '',
      String language = '',
      String currency = '',
      String checkInDate = '',
      String checkOutDate = '',
      String page = '',
      String perPage = ''}) async {
    var body = {
      "engine": engine,
      'q': query,
      "gl": country,
      "hl": language,
      "page": page,
      "num": perPage,
    };

    body.removeWhere((key, value) => value.isEmpty);

    return runAPI('/search', HttpRequestType.post, body: body);
  }
}

final hotelProvider = HotelProvider();
