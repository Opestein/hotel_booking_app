import 'package:async/async.dart';
import 'package:hotel_booking_app/src/data/server_provider/hotel_provider/hotel_provider.dart';
import 'package:hotel_booking_app/src/utils/operation.dart';

class _HotelRepo {
  CancelableOperation? _cancelableOperation;

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation!.cancel();
  }

  Future<Operation> getHotels(
      {String query = '',
      String country = '',
      String language = '',
      String currency = '',
      String checkInDate = '',
      String checkOutDate = '',
      String page = '1',
      String perPage = '20'}) async {
    return await hotelProvider.getHotels(
        engine: 'google_hotels',
        query: query,
        country: country,
        language: language,
        currency: currency,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        page: page,
        perPage: perPage);
  }
}

final hotelRepo = _HotelRepo();
