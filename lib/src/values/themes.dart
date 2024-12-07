// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/values/values.dart';

// ThemeMode
class HotelBookingThemeMode {
  const HotelBookingThemeMode(this.themeMode, this.label, this.index);

  final ThemeMode themeMode;
  final String label;
  final int index;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final HotelBookingThemeMode typedOther = other;
    return themeMode == typedOther.themeMode &&
        index == typedOther.index &&
        label == typedOther.label;
  }

  @override
  int get hashCode => hashValues(themeMode, label, index);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<HotelBookingThemeMode> kAllHotelBookingThemeModeValues =
    <HotelBookingThemeMode>[
  HotelBookingThemeMode(ThemeMode.system, 'Default', 0),
  HotelBookingThemeMode(ThemeMode.dark, 'Dark', 1),
  HotelBookingThemeMode(ThemeMode.light, 'Light', 2),
];

class HotelBookingTheme {
  const HotelBookingTheme._(this.name, this.data);

  final String name;
  final ThemeData data;
}

final HotelBookingTheme kDarkHotelBookingTheme =
    HotelBookingTheme._('Dark', _buildDarkTheme());
final HotelBookingTheme kLightHotelBookingTheme =
    HotelBookingTheme._('Light', _buildLightTheme());

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: base.titleLarge!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displaySmall: base.displaySmall!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displayMedium: base.displayMedium!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displayLarge: base.displayLarge!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    titleSmall: base.titleSmall!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    titleMedium: base.titleMedium!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    labelLarge: base.labelLarge!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kMediumWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodyMedium: base.bodyMedium!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodyLarge: base.bodyLarge!.copyWith(
        fontWeight: kRegularWeight,
        color: AppColors.primaryText,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    labelSmall: base.labelSmall!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodySmall: base.bodySmall!.copyWith(
        color: AppColors.primaryText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
  );
}

TextTheme _buildDarkTextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: base.titleLarge!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displaySmall: base.displaySmall!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displayMedium: base.displayMedium!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    displayLarge: base.displayLarge!.copyWith(
        fontFamily: kDefaultFontFamily,
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontStyle: FontStyle.normal),
    titleSmall: base.titleSmall!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    titleMedium: base.titleMedium!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    labelLarge: base.labelLarge!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kMediumWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodyMedium: base.bodyMedium!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodyLarge: base.bodyLarge!.copyWith(
        fontWeight: kRegularWeight,
        color: AppColors.primaryDarkText,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    labelSmall: base.labelSmall!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
    bodySmall: base.bodySmall!.copyWith(
        color: AppColors.primaryDarkText,
        fontWeight: kRegularWeight,
        fontFamily: kDefaultFontFamily,
        fontStyle: FontStyle.normal),
  );
}

ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: AppColors.primaryDarkElement,
      secondary: AppColors.secondaryDarkElement,
      surface: AppColors.accentDarkBackground,
      error: AppColors.errorColor,
      errorContainer: AppColors.errorBgColor);
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: AppColors.primaryDarkElement,
    indicatorColor: AppColors.primaryDarkElement,
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: AppColors.toggleDarkActive,
        selectedColor: AppColors.toggleDarkActive,
        disabledColor: AppColors.toggleDarkInActive),
    splashFactory: InkRipple.splashFactory,
    canvasColor: AppColors.cardDarkBg,
    scaffoldBackgroundColor: AppColors.primaryDarkBackground,
    dividerColor: AppColors.dividerDark,
    primaryIconTheme: IconThemeData(color: AppColors.iconBlueColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBgDark,
        selectedItemColor: AppColors.bottomNavIconSelectedDark,
        unselectedItemColor: AppColors.bottomNavIconUnSelectedDark,
        selectedIconTheme:
            IconThemeData(color: AppColors.bottomNavIconSelectedDark),
        unselectedIconTheme:
            IconThemeData(color: AppColors.bottomNavIconUnSelectedDark),
        selectedLabelStyle: TextStyle(
            color: AppColors.bottomNavIconSelectedDark,
            fontWeight: kMediumWeight),
        unselectedLabelStyle: TextStyle(
            color: AppColors.bottomNavIconUnSelectedDark,
            fontWeight: kMediumWeight),
        showUnselectedLabels: true,
        showSelectedLabels: true),
    iconTheme: IconThemeData(color: AppColors.iconBlueColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle:
          TextStyle(color: AppColors.accentDarkText, fontWeight: kMediumWeight),
      hintStyle: TextStyle(color: AppColors.fourthDarkText),
       fillColor: AppColors.editTextBgDark,
      focusColor: AppColors.editTextFocusedBgDark,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.editTextUnFocusedBorderDark, width: 1),
          borderRadius: Radii.k8pxRadius),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.editTextUnFocusedBorderDark, width: 0.5),
          borderRadius: Radii.k8pxRadius),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.editTextFocusedBorderDark,
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: Radii.k8pxRadius),
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.editTextUnFocusedBorderDark, width: 1),
          borderRadius: Radii.k8pxRadius),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(AppColors.primaryDarkButton)),
    ),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.dark().copyWith(
            primary: AppColors.primaryDarkButton,
            secondary: AppColors.secondaryDarkButton,
            error: AppColors.errorColor,
            errorContainer: AppColors.errorBgColor),
        textTheme: ButtonTextTheme.normal,
        buttonColor: AppColors.primaryDarkButton),
    cardColor: AppColors.cardDarkBg,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.primaryDarkElement,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleDarkActive;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleDarkActive;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleDarkActive;
        }
        return null;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleDarkActive;
        }
        return null;
      }),
    ),
  );

  return base.copyWith(
      textTheme: _buildDarkTextTheme(base.textTheme),
      primaryTextTheme: _buildDarkTextTheme(base.primaryTextTheme));
}

ThemeData _buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: AppColors.primaryElement,
      secondary: AppColors.secondaryElement,
      surface: AppColors.accentBackground,
      error: AppColors.errorColor,
      errorContainer: AppColors.errorBgColor);
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: AppColors.primaryElement,
    indicatorColor: AppColors.primaryElement,
    toggleButtonsTheme: ToggleButtonsThemeData(
        color: AppColors.toggleActive,
        selectedColor: AppColors.toggleActive,
        disabledColor: AppColors.toggleInActive),
    splashFactory: InkRipple.splashFactory,
    canvasColor: AppColors.cardBg,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    dividerColor: AppColors.divider,
    primaryIconTheme: IconThemeData(color: AppColors.iconBlueColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBg,
        selectedItemColor: AppColors.bottomNavIconSelected,
        unselectedItemColor: AppColors.bottomNavIconUnSelected,
        selectedIconTheme:
            IconThemeData(color: AppColors.bottomNavIconSelected),
        unselectedIconTheme:
            IconThemeData(color: AppColors.bottomNavIconUnSelected),
        selectedLabelStyle: TextStyle(
            color: AppColors.bottomNavIconSelected, fontWeight: kMediumWeight),
        unselectedLabelStyle: TextStyle(
            color: AppColors.bottomNavIconUnSelected,
            fontWeight: kMediumWeight),
        showUnselectedLabels: true,
        showSelectedLabels: true),
    iconTheme: IconThemeData(color: AppColors.iconBlueColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle:
          TextStyle(color: AppColors.accentText, fontWeight: kMediumWeight),
      hintStyle: TextStyle(color: AppColors.fourthText),
      fillColor: AppColors.editTextBg,
      focusColor: AppColors.editTextFocusedBg,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.editTextUnFocusedBorder, width: 1),
          borderRadius: Radii.k8pxRadius),
      disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.editTextUnFocusedBorder, width: 0.5),
          borderRadius: Radii.k8pxRadius),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.editTextFocusedBorder,
              width: 1.5,
              style: BorderStyle.solid),
          borderRadius: Radii.k8pxRadius),
      border: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.editTextUnFocusedBorder, width: 1),
          borderRadius: Radii.k8pxRadius),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryButton)),
    ),
    buttonTheme: ButtonThemeData(
        colorScheme: const ColorScheme.light().copyWith(
            primary: AppColors.primaryButton,
            secondary: AppColors.secondaryButton,
            error: AppColors.errorColor,
            errorContainer: AppColors.errorBgColor),
        textTheme: ButtonTextTheme.normal,
        buttonColor: AppColors.primaryButton),
    cardColor: AppColors.cardBg,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.primaryElement,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleActive;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleActive;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleActive;
        }
        return null;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.toggleActive;
        }
        return null;
      }),
    ),
  );

  return base.copyWith(
      textTheme: _buildLightTextTheme(base.textTheme),
      primaryTextTheme: _buildLightTextTheme(base.primaryTextTheme));
}
