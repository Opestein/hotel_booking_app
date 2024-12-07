// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:hotel_booking_app/src/values/languages.dart';
import 'package:hotel_booking_app/src/values/themes.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/app_translations.dart';
import 'package:hotel_booking_app/src/application.dart';

class SettingOptions {
  SettingOptions({
    this.appTranslationsDelegate,
    this.notification,
    this.theme,
    this.darkTheme,
    this.hotelBookingThemeMode,
    this.hotelBookingLanguage,
    this.textDirection = TextDirection.ltr,
    this.timeDilation = 1.0,
    this.platform,
    this.showOffscreenLayersCheckerboard = false,
    this.showRasterCacheImagesCheckerboard = false,
    this.showPerformanceOverlay = false,
  });

  final HotelBookingLanguage? hotelBookingLanguage;
  final HotelBookingThemeMode? hotelBookingThemeMode;
  final AppTranslationsDelegate? appTranslationsDelegate;
  final bool? notification;
  final HotelBookingTheme? theme;
  final HotelBookingTheme? darkTheme;
  final TextDirection textDirection;
  final double timeDilation;
  final TargetPlatform? platform;
  final bool showPerformanceOverlay;
  final bool showRasterCacheImagesCheckerboard;
  final bool showOffscreenLayersCheckerboard;

  SettingOptions copyWith({
    AppTranslationsDelegate? appTranslationsDelegate,
    bool? notification,
    HotelBookingLanguage? hotelBookingLanguage,
    HotelBookingThemeMode? hotelBookingThemeMode,
    HotelBookingTheme? theme,
    HotelBookingTheme? darkTheme,
    TextDirection? textDirection,
    double? timeDilation,
    TargetPlatform? platform,
    bool? showPerformanceOverlay,
    bool? showRasterCacheImagesCheckerboard,
    bool? showOffscreenLayersCheckerboard,
  }) {
    return SettingOptions(
      appTranslationsDelegate: appTranslationsDelegate ??
          AppTranslationsDelegate(
              newLocale: application.supportedLocales().first),
      notification: notification ?? this.notification,
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      hotelBookingThemeMode:
          hotelBookingThemeMode ?? this.hotelBookingThemeMode,
      hotelBookingLanguage: hotelBookingLanguage ?? this.hotelBookingLanguage,
      textDirection: textDirection ?? this.textDirection,
      timeDilation: timeDilation ?? this.timeDilation,
      platform: platform ?? this.platform,
      showPerformanceOverlay:
          showPerformanceOverlay ?? this.showPerformanceOverlay,
      showOffscreenLayersCheckerboard: showOffscreenLayersCheckerboard ??
          this.showOffscreenLayersCheckerboard,
      showRasterCacheImagesCheckerboard: showRasterCacheImagesCheckerboard ??
          this.showRasterCacheImagesCheckerboard,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final SettingOptions typedOther = other;
    return appTranslationsDelegate == typedOther.appTranslationsDelegate &&
        notification == typedOther.notification &&
        darkTheme == typedOther.darkTheme &&
        theme == typedOther.theme &&
        hotelBookingThemeMode == typedOther.hotelBookingThemeMode &&
        hotelBookingLanguage == typedOther.hotelBookingLanguage &&
        textDirection == typedOther.textDirection &&
        platform == typedOther.platform &&
        showPerformanceOverlay == typedOther.showPerformanceOverlay &&
        showRasterCacheImagesCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard &&
        showOffscreenLayersCheckerboard ==
            typedOther.showRasterCacheImagesCheckerboard;
  }

  @override
  int get hashCode => Object.hash(
        appTranslationsDelegate,
        notification,
        theme,
        darkTheme,
        hotelBookingThemeMode,
        hotelBookingLanguage,
        textDirection,
        timeDilation,
        platform,
        showPerformanceOverlay,
        showRasterCacheImagesCheckerboard,
        showOffscreenLayersCheckerboard,
      );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}
