// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:hotel_booking_app/src/values/values.dart';
import 'package:flutter/material.dart';

class HotelBookingLanguage {
  const HotelBookingLanguage(
      {required this.locale, this.label, this.labelInEnglish});

  final Locale locale;
  final String? label;
  final String? labelInEnglish;

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<HotelBookingLanguage> kAllHotelBookingLanguageValues =
    <HotelBookingLanguage>[
  HotelBookingLanguage(
      locale: Locale('en', "UK"), label: 'English', labelInEnglish: 'English'),
  HotelBookingLanguage(
      locale: Locale('es', "ES"), label: 'Español', labelInEnglish: 'Spanish'),
];
