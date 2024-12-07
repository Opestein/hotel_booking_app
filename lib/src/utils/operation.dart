import 'dart:convert';

import 'package:hotel_booking_app/src/data/server_provider/base_network_call_handler.dart';
import 'package:hotel_booking_app/src/model/message_only_response.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:flutter/material.dart';

typedef OperationCompleted = Future<Operation> Function(Operation operation);

class Operation {
  final dynamic _result;
  int? code;

  Operation(this.code, this._result);

  bool get shouldDisplayMessage {
    if (code == 0) {
      return false;
    } else if (_result == null) {
      return false;
    } else {
      return true;
    }
  }

  bool get ok => code == 200 || code == 201;

  String getMessage(BuildContext context) {
    if (code == 0 || code == 500) {
      return localise.noInternetConnection;
    } else if (code == 408) {
      return localise.connectionTimeout;
    } else {
      return '$_result';
    }
  }

  static error() => Operation(
      503, MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));

  static errorData() =>
      Operation(500, MessageOnlyResponse.fromJson(json.decode(kPlatformError)));

  static errorTextOnly(String data) =>
      Operation(433, MessageOnlyResponse.fromJson({'message': data}));

  bool get succeeded => code! >= 200 && code! <= 226;

  dynamic get result => _result;
}
