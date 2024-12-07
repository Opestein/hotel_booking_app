import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/app.dart';

Type _getType<B>() => B;

class AppConfig<B> extends InheritedWidget {
  final B? bloc;
  final String? replacementUrlA;
  final String? replacementUrlB;
  final HotelBookingAppState hotelBookingAppState;

  const AppConfig({
    Key? key,
    this.bloc,
    this.replacementUrlA,
    this.replacementUrlB,
    required this.hotelBookingAppState,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppConfig<B> oldWidget) {
    return true;
//    return oldWidget.bloc != bloc;
  }

  static B of<B>(BuildContext context) {
    final AppConfig<B> provider =
        context.dependOnInheritedWidgetOfExactType<AppConfig<B>>()!;

    return provider.bloc!;
  }
}
