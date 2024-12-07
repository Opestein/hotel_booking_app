import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/data/server_provider/base_network_call_handler.dart';
import 'package:hotel_booking_app/src/data/server_provider/hotel_provider/hotel_repo.dart';
import 'package:hotel_booking_app/src/model/hotel/hotel_list_response.dart';
import 'package:hotel_booking_app/src/model/message_only_response.dart';
import 'package:rxdart/rxdart.dart';

class HotelListBloc with BaseBloc<List<Place>, String> {
  int pageNumber = 1;

  int perPage = 20;
  double pixels = 0.0;
  String _query = 'Bali+Resorts',
      _country = 'us',
      _language = 'en',
      _currency = '',
      _checkInDate = '',
      _checkOutDate = '';

  String get query => _query;

  String get country => _country;

  String get language => _language;

  String get checkInDate => _checkInDate;

  String get checkOutDate => _checkOutDate;

  final BehaviorSubject<bool> _loaderSubject = BehaviorSubject<bool>();

  BehaviorSubject<bool> get loaderSubject => _loaderSubject;

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Sink<ScrollNotification> get sink => _controller.sink;

  HotelListBloc() {
    _controller.listen((notification) => fetchCurrent(notification));
    _loaderSubject.add(false);
  }

  List<Place> list = [];

  reload() {
    initFetch(
        query: _query,
        country: _country,
        currency: _currency,
        language: _language,
        checkInDate: _checkInDate,
        checkOutDate: _checkOutDate);
  }

  ///Use this when you want to load only data being passed .i.e. reset filter to default
  filter(
      {String query = '',
      String country = '',
      String language = '',
      String currency = '',
      String checkInDate = '',
      String checkOutDate = ''}) {
    initFetch(
        query: query,
        country: country,
        language: language,
        currency: currency,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate);
  }

  ///Use this as it use old data if null is passed
  filterWithOldValuesIfEmpty(
      {String? query,
      String? country,
      String? language,
      String? currency,
      String? checkInDate,
      String? checkOutDate}) {
    initFetch(
        query: query ?? _query,
        country: country ?? _country,
        language: language ?? _language,
        currency: currency ?? _currency,
        checkInDate: checkInDate ?? _checkInDate,
        checkOutDate: checkOutDate ?? _checkOutDate);
  }

  initIfEmptyOrError(
      {String? query,
      String? country,
      String? language,
      String? currency,
      String? checkInDate,
      String? checkOutDate}) {
    if (behaviorSubject.hasValue && behaviorSubject.value.model != null) {
      return;
    }

    initFetch(
        query: query ?? _query,
        country: country ?? _country,
        language: language ?? _language,
        currency: currency ?? _currency,
        checkInDate: checkInDate ?? _checkInDate,
        checkOutDate: checkOutDate ?? _checkOutDate);
  }

  initFetch({
    Function()? onSuccessCallback,
    String query = '',
    String country = '',
    String language = '',
    String currency = '',
    String checkInDate = '',
    String checkOutDate = '',
  }) async {
    _loaderSubject.add(false);
    pageNumber = 1;
    list = [];
    _query = query;
    _country = country;
    _currency = currency;
    _language = language;
    _checkInDate = checkInDate;
    _checkOutDate = checkOutDate;

    invalidate();
    var operation = await hotelRepo.getHotels(
        query: _query,
        country: _country,
        currency: _currency,
        language: _language,
        checkInDate: _checkInDate,
        checkOutDate: _checkOutDate,
        page: pageNumber.toString(),
        perPage: perPage.toString());
    if (operation.code == 200 || operation.code == 201) {
      HotelListResponse response = HotelListResponse.fromJson(operation.result);

      if ((response.places?.length ?? 0) > 0) {
        pageNumber++;
        list = response.places ?? [];

        ///todo: use widget height to calculate the items to render
        if (list.length > 10) {
          if (!_loaderSubject.isClosed) {
            _loaderSubject.add(true);
          }
        }
        addToModel(list);

        if (onSuccessCallback != null) onSuccessCallback();
        return;
      }

      addToError("No item found");
      if (!_loaderSubject.isClosed) {
        _loaderSubject.add(false);
      }
    } else {
      addToError((operation.result as MessageOnlyResponse).message ??
          kNetworkGeneralText);
      if (!_loaderSubject.isClosed) {
        _loaderSubject.add(false);
      }
    }
  }

  fetchCurrent(ScrollNotification notification) async {
    if (pageNumber != 1) {
      //this shows the loader right before the scroll gets to the last item
      // and then it also checks if the last item has been loaded
      // if (notification.metrics.pixels >=
      //     notification.metrics.maxScrollExtent - 20 &&
      //     pixels != notification.metrics.pixels) {
      //   if (!_behaviorSubject!.isClosed) {
      //     _list.showLoading=true;
      //     _behaviorSubject!.sink.add(_list);
      //   }
      // }

      // print('value changed');
      // _loaderSubject!.add(true);
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
          pixels != notification.metrics.pixels) {
        pixels = notification.metrics.pixels;

        var operation = await hotelRepo.getHotels(
            query: _query,
            country: _country,
            currency: _currency,
            language: _language,
            checkInDate: _checkInDate,
            checkOutDate: _checkOutDate,
            page: pageNumber.toString(),
            perPage: perPage.toString());

        if (operation.code == 200 || operation.code == 201) {
          HotelListResponse response =
              HotelListResponse.fromJson(operation.result);
          if ((response.places?.length ?? 0) > 0) {
            list.addAll(response.places ?? []);
            pageNumber++;
            addToModel(list);
            _loaderSubject.add(true);

            return;
          }
        }

        _loaderSubject.add(false);
      }
    }
  }

  invalidate() {
    list = [];
    setAsLoading();
    _loaderSubject.add(false);
  }

  dispose() {
    list = [];
    _controller.close();
    disposeBaseBloc();
    _loaderSubject.close();
  }
}

final hotelListBloc = HotelListBloc();
