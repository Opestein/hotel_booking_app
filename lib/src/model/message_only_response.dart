
import 'package:hotel_booking_app/src/data/server_provider/base_network_call_handler.dart';

class MessageOnlyResponse {
  final int? statusCode;
  String? message;
  final Err? err;

  MessageOnlyResponse({
    this.statusCode,
    this.message,
    this.err,
  }) {
    if (message == null && (err != null && err!.message != null)) {
      message = err!.message;
    }

    if (statusCode == 401 && (message ?? '').isEmpty) {
      message = 'Unauthorized';
    }

    if ((message ?? '').isEmpty) {
      message = kNetworkGeneralText;
    }
  }

  factory MessageOnlyResponse.fromJson(Map<String, dynamic> json,
      {int? statusCode}) =>
      MessageOnlyResponse(
        statusCode: json['statusCode'] ?? statusCode,
        message: json["message"] ??
            (json['error'] != null && json['error'] is String
                ? json['error'].toString()
                : null),
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
  };
}

class Err {
  Err({
    this.message,
  });

  final String? message;

  factory Err.fromJson(Map<String, dynamic> json) => Err(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
