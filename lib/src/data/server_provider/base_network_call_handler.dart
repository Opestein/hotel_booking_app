/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro]. All rights reserved.
    */

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/mixin/logout_helper.dart';
import 'package:hotel_booking_app/src/model/hotel/login_response.dart';
import 'package:hotel_booking_app/src/model/message_only_response.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/utils/mime_converter.dart';
import 'package:hotel_booking_app/src/utils/operation.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

typedef OnResponse = Future<Operation> Function(Operation operation);

const kConnectionTimeOutCode = 522;
const kConnectionCaughtErrorCode = 822;
const kShortTimeoutSec = 45;
const kMediumTimeout = 60;
const kLongTimeout = 120;

const kValidateCode = 600;

/// This is for connection/handshake error from DIO
const kMaxGetRequestRetryTimes = 4;

final kTimeoutResponse = Response(
    data: {"message": kTimeoutText},
    statusCode: kConnectionTimeOutCode,
    requestOptions: RequestOptions(path: ''));

final kPlatformExceptionResponse = Response(
    data: {"message": kPlatformText},
    statusCode: 505,
    requestOptions: RequestOptions(path: ''));
final kHandshakeExceptionResponse = Response(
    data: {"message": kHandshakeText},
    statusCode: 506,
    requestOptions: RequestOptions(path: ''));
final kHTTPExceptionResponse = Response(
    data: {"message": kHttpErrorText},
    statusCode: 507,
    requestOptions: RequestOptions(path: ''));
final kSocketExceptionResponse = Response(
    data: {"message": kSocketExceptionText},
    statusCode: 508,
    requestOptions: RequestOptions(path: ''));
final kGeneralResponse = Response(
    data: {"message": kNetworkGeneralText},
    statusCode: 509,
    requestOptions: RequestOptions(path: ''));

Response networkErrorResponse(error) {
  if (error is HandshakeException) {
    if (kDebugMode) {
      print(
          'HandshakeException type: ${error.osError?.message}${error.osError?.errorCode}\n${error.type}\n${error.message}');
    }
    return kHandshakeExceptionResponse;
  } else if (error == HttpException) {
    return kHTTPExceptionResponse;
  } else if (error == SocketException) {
    return kSocketExceptionResponse;
  } else if (error is DioException) {
    if (kDebugMode) {
      print(
          'DioException type: ${error.error}\nhmmn: ${error.response?.statusCode} ${error.response?.statusMessage} ${error.response?.data}\n${error.type.name}\n${error.message}\n${error.response?.statusCode}\n${error.response?.statusMessage}');
    }
    return kHandshakeExceptionResponse;
  }
  return kGeneralResponse;
}

const String kTimeoutText = 'Connection Timed out';
const String kHandshakeText = 'Connection Timed out.\nPlease try again';
const String kPlatformText = 'Unable to process information';
const String kHttpErrorText = 'Please check you network settings';
const String kSocketExceptionText = 'Please check you network settings';
const String kNetworkGeneralText =
    'An error has occurred while connecting to server';
const String kNoInternetText = 'No internet connection';
const String kLogoutText = 'Unauthorized user';
const String kSuccessText = 'Successful';

const String kConnectionTimedOut = '{"message":"$kTimeoutText"}';
const String kHandshakeError = '{"message":"$kHandshakeText"}';
const String kNetworkGeneralError = '{"message":"$kNetworkGeneralText"}';
const String kPlatformError = '{"message":"$kPlatformText"}';
const String kLogoutError = '{"message":"$kLogoutText"}';
const String kSuccess = '{"message":"$kSuccessText"}';
const String kInvalidCredentials = '{"message":"Invalid Credentials"}';
const String kInvalidPhoneNumber = '{"message":"Invalid Phone number"}';
const String kIncorrectPassword =
    '{"message":"Incorrect Password Please Check And Try Again"}';
const String kIncorrectPin =
    '{"message":"Incorrect Pin Please Check And Try Again"}';
const String kUnableToFindOTP =
    '{"message":"Unable to find provided OTP please check and try again"}';
const String kPhoneNumberExist = '{"message":"Phone Number Already Exist"}';
const String kEmailExistOrPhone =
    '{"message":"Email or Phone Number already exist"}';
const String kInvalidToken = '{"message":"Invalid token"}';
const String kErrorOccurred = '{"message":"An error occurred"}';
const String kUnableToProcess =
    '{"message":"Hello, Unable To Process Your Request At The Moment. Please try again"}';
const String kCheckField = '{"message":"Please check fields"}';
const String kIncorrectQuestionOrAnswer =
    '{"message":"Incorrect Question or Answer"}';
const String kInvalidCurrentPassword =
    '{"message":"Current password is incorrect please check and try again"}';

const apiKey = 'X-API-KEY';

class BaseNetworkCallHandler with LogoutHelper {
  Future<Operation> runAPI(String path, HttpRequestType httpRequestType,
      {Map<String, dynamic> body = const {},
      Map<String, dynamic> header = const {},
      String baseurl = '',
      bool useIsLoggedIn = true,
      bool convertBodyToFormData = false,
      OnResponse? onResponse,
      OnResponse? onNoDataResponse,
      OnResponse? onCaughtErrorResponse}) async {
    String baseurl0 =
        baseurl.isNotEmpty ? baseurl : SingletonData.singletonData.baseApiURL!;

    try {
      String url = baseurl;
      if (url.isEmpty) {
        if (Platform.isAndroid || Platform.isIOS) {
          url = baseurl0;
        } else {
          url = baseurl0;
        }

        if (url.isEmpty) {
          return Operation(500,
              MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));
        }
      }
      url = url + path;

      Map<String, dynamic> masterHeader = header;
      var appSettings = await appSettingsBloc.fetchAppSettings();

      if (masterHeader.isEmpty) {
        masterHeader = {
          if (!convertBodyToFormData) 'Content-Type': 'application/json',
          apiKey: SingletonData.singletonData.apiKey ?? '',
        };

        if (useIsLoggedIn && (await appSettings.isLoggedIn)) {
          masterHeader = {
            'Authorization': 'Bearer ${appSettings.hotelResponse?.token}',
            apiKey: SingletonData.singletonData.apiKey ?? '',
            if (!convertBodyToFormData) 'Content-Type': 'application/json',
          };
        }
      }

      if ((await appSettings.isLoggedIn) &&
          (masterHeader['Authorization'] == null ||
              masterHeader['Authorization'].toString().isEmpty)) {
        LogoutHelper logoutHelper = LogoutHelper();
        logoutHelper.logout();

        return Operation(500,
            MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError)));
      }

      Response response;
      if (httpRequestType == HttpRequestType.post) {
        response = await _post(url, body, masterHeader, convertBodyToFormData);
      } else if (httpRequestType == HttpRequestType.get) {
        response = await _get(url, masterHeader, retryCount: 1);
      } else if (httpRequestType == HttpRequestType.patch) {
        response = await _patch(url, body, masterHeader, convertBodyToFormData);
      } else if (httpRequestType == HttpRequestType.put) {
        response = await _put(url, body, masterHeader, convertBodyToFormData);
      } else if (httpRequestType == HttpRequestType.delete) {
        response =
            await _delete(url, body, masterHeader, convertBodyToFormData);
      } else {
        if (onCaughtErrorResponse != null) {
          return onCaughtErrorResponse(json.decode(kPlatformError));
        } else {
          return Operation(
              500, MessageOnlyResponse.fromJson(json.decode(kPlatformError)));
        }
      }

      if (kDebugMode) {
        print('url $url');
        print('header $masterHeader');
        print('body $body');
        print('code ${response.statusCode}');
        print(json.encode(response.data));
        // log(response.data.toString(), level: 2000);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (onResponse != null) {
          return onResponse(Operation(response.statusCode, response.data));
        }
        return Operation(response.statusCode, response.data);
      } else {
        if (onNoDataResponse != null) {
          return onNoDataResponse(Operation(
              response.statusCode,
              (response.data is Map || response.data is List)
                  ? response.data
                  : kNetworkGeneralText));
        }

        try {
          return Operation(
              response.statusCode,
              MessageOnlyResponse.fromJson(response.data,
                  statusCode: response.statusCode));
        } catch (err) {
          return Operation(
              response.statusCode,
              MessageOnlyResponse.fromJson(json.decode(kNetworkGeneralError),
                  statusCode: response.statusCode));
        }
      }
    } catch (err) {
      if (onCaughtErrorResponse != null) {
        return onCaughtErrorResponse(Operation(
            kConnectionCaughtErrorCode, json.decode(kNetworkGeneralError)));
      } else {
        return Operation(
            kConnectionCaughtErrorCode,
            MessageOnlyResponse(
                statusCode: kConnectionCaughtErrorCode,
                message: kNetworkGeneralText));
      }
    }
  }

  Future<Response> _post(String url, Map<String, dynamic> body,
      Map<String, dynamic> header, bool convertBodyToFormData) async {
    var response = await SingletonData.singletonData.dio
        .post(
      url,
      data: convertBodyToFormData ? convertMapToFormData(body) : body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (statusCode) {
            if (statusCode == null) {
              return false;
            }

            if (statusCode == 401) {
              return true;
            }
            return statusCode < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kMediumTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _get(String url, Map<String, dynamic> header,
      {int retryCount = kMaxGetRequestRetryTimes}) async {
    var response = await SingletonData.singletonData.dio
        .get(
      url,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kMediumTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    if ((response.statusCode == kConnectionTimeOutCode ||
            (response.statusCode! >= 505 && response.statusCode! <= 509)) &&
        retryCount < kMaxGetRequestRetryTimes) {
      if (kDebugMode) {
        print('retry count: $retryCount');
      }
      return _get(url, header, retryCount: retryCount + 1);
    }

    return response;
  }

  Future<Response> _patch(String url, Map<String, dynamic> body,
      Map<String, dynamic> header, bool convertBodyToFormData) async {
    var response = await SingletonData.singletonData.dio
        .patch(
      url,
      data: convertBodyToFormData ? convertMapToFormData(body) : body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kMediumTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _put(String url, Map<String, dynamic> body,
      Map<String, dynamic> header, bool convertBodyToFormData) async {
    var response = await SingletonData.singletonData.dio
        .put(
      url,
      data: convertBodyToFormData ? convertMapToFormData(body) : body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kMediumTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  Future<Response> _delete(String url, Map<String, dynamic> body,
      Map<String, dynamic> header, bool convertBodyToFormData) async {
    var response = await SingletonData.singletonData.dio
        .delete(
      url,
      data: convertBodyToFormData ? convertMapToFormData(body) : body,
      options: Options(
          headers: header,
          responseType: ResponseType.json,
          followRedirects: false,
          validateStatus: (status) {
            return status! < kValidateCode;
          }),
    )
        .timeout(const Duration(minutes: kMediumTimeout), onTimeout: () {
      return kTimeoutResponse;
    }).catchError((error) {
      return networkErrorResponse(error);
    });

    return response;
  }

  FormData convertMapToFormData(Map<String, dynamic> map) {
    var data = FormData();

    for (int i = 0; i < map.length; i++) {
      if (map.values.elementAt(i) != null && map.values.elementAt(i) is File ||
          map.values.elementAt(i) is List<File>) {
        if (map.values.elementAt(i) is List<File>) {
          var fileList = map.values.elementAt(i) as List<File>;
          for (int i = 0; i < fileList.length; i++) {
            File file = fileList.elementAt(i);

            data.files.add(innerListProcessor(map.keys.elementAt(i), file,
                ext: map['${map.keys.elementAt(i)}_ext']));
          }
        } else {
          File file = map.values.elementAt(i);

          data.files.add(innerListProcessor(map.keys.elementAt(i), file,
              ext: map['${map.keys.elementAt(i)}_ext']));
        }
      } else if (map.values.elementAt(i) != null) {
        data.fields.add(MapEntry(
            map.keys.elementAt(i), map.values.elementAt(i).toString()));
      }
    }

    return data;
  }

  MapEntry<String, MultipartFile> innerListProcessor(String key, File file,
      {String? ext}) {
    String path = file.path;
    ext = ext ?? path.substring(path.lastIndexOf('.'));

    var contentList = ext.mediaType.split('/');

    String type = 'application';

    String subType = 'octet-stream';

    if (kDebugMode) {
      print('fileSubType:$ext');
    }
    if (contentList.isNotEmpty) {
      type = contentList.isNotEmpty ? contentList.first : '';
      subType = contentList.length > 1 ? contentList.elementAt(1) : subType;
    }

    var multiPartFile = MultipartFile.fromFileSync(path,
        filename:
            '${key.trim().replaceAll(' ', '_')}_${DateTime.now().toIso8601String().replaceAll(' ', '')}$ext',
        contentType: MediaType(type, subType));

    return MapEntry(key, multiPartFile);
  }
}
