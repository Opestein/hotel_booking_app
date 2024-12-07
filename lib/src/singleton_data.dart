import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingletonData {
  static final SingletonData _instance = new SingletonData.internal();

  factory SingletonData() => _instance;

  SingletonData._();

  static final SingletonData singletonData = SingletonData._();

  SingletonData.internal();

  ///navigator key
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  ///route Observer
  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  /// storage

  // shared preferences
  static SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) return _preferences!;
    _preferences = await initPreferences();
    return _preferences!;
  }

  initPreferences() async {
    return await SharedPreferences.getInstance();
  }

  //Dio
  static Dio? _dio;

  Dio get dio {
    if (_dio != null) return _dio!;
    _dio = initDio();
    return _dio!;
  }

  initDio() {
    return Dio();
  }

  ///Base Url
  static String? _baseApiURL;

  String? get baseApiURL {
    if (_baseApiURL != null) return _baseApiURL;
    _baseApiURL = '';
    return _baseApiURL;
  }

  initApiBaseURL(String baseApiURL) {
    _baseApiURL = baseApiURL;
    return _baseApiURL;
  }

  ///API Key
  static String? _apiKey;

  String? get apiKey {
    if (_apiKey != null) return _apiKey;
    _apiKey = '';
    return _apiKey;
  }

  initApiKey(String apiKey) {
    _apiKey = apiKey;
    return _apiKey;
  }

  ///Environment Flag
  static Env? _env;

  Env? get env {
    if (_env != null) return _env;
    _env = Env.live;
    return _env;
  }

  initEnv(Env env) {
    _env = env;
    return _env;
  }
}
