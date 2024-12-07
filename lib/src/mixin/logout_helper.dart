import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/bloc/hotel_list_bloc.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:flutter/cupertino.dart';

typedef CompleteLogout = Function();

mixin class LogoutHelper {
  CompleteLogout? _completeLogout;
  BuildContext _buildContext =
      SingletonData.singletonData.navigationKey.currentState!.context;

  logout({BuildContext? context, CompleteLogout? completeLogout}) async {
    _buildContext = context ?? _buildContext;
    _globalCleanup();
    if (completeLogout != null) {
      completeLogout();
    }
  }

  _globalCleanup() {
    _cleanupUI();
    hotelListBloc.invalidate();
    if (_completeLogout != null) {
      _completeLogout!();
    }

    var context =
        SingletonData.singletonData.navigationKey.currentState?.context;
    if (context != null) {
      if (Navigator.canPop(context)) {}
    }
  }

  _cleanupUI() {
    var injector = HotelBookingApp.of(_buildContext);
  }
}
