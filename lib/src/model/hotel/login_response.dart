import 'package:hotel_booking_app/src/model/hotel/hotel_list_response.dart';

class HotelResponse {
  HotelResponse(
      {this.status, this.message, this.token, this.refreshToken, this.cidList});

  final String? status;
  final String? message;
  String? token;
  String? refreshToken;
  List<Place>? cidList;

  factory HotelResponse.fromJson(Map<String, dynamic> json) => HotelResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        cidList: json["cidList"] == null
            ? []
            : List<Place>.from(json["cidList"]!.map((x) => Place.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "refreshToken": refreshToken,
        "cidList": cidList == null
            ? []
            : List<dynamic>.from(cidList!.map((x) => x.toJson())),
      };
}
