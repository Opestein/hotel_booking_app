/*
*  colors.dart
*  Buenro
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro]. All rights reserved.
    */

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackground = Color(0xFFFFFFFF);
  static const Color secondaryBackground = Color(0xFFFBFBFB);
  static const Color accentBackground = Color(0xFFF7F7F7);

  static const Color primaryDarkBackground = Color(0xFFFFFFFF);
  static const Color secondaryDarkBackground = Color(0xFFFBFBFB);
  static const Color accentDarkBackground = Color(0xFFF7F7F7);

  static const Color primaryElement = Color(0xFF0F2A50);
  static const Color secondaryElement = Color(0xFF083458);

  static const Color primaryBlack = Color(0xFF000000);

  // static const Color primaryDarkElement = Color(0xFF0F2A50);
  // static const Color secondaryDarkElement = Color(0xFF083458); 030D45 D1D1D6

  static const Color primaryDarkElement = Color(0xFFFFFFFF);
  static const Color secondaryDarkElement = Color(0xFF070707);

  static const Color appBarColor = Color(0xFF0F2A50);
  static const Color dashBgColor = Color(0xFF0F2A50);
  static const Color primaryWhiteText = Color(0xFFFFFFFF);
  static const Color balanceCardColor = Color(0x5917568B);
  static const Color balanceAmountColor = Color(0xFF083458);
  static const Color walletBalanceTextColor = Color(0xFF82898F);
  static const Color activityButtonBkg = Color(0xFFEBEEF1);
  static const Color topWidgetGradientColor = Color(0xFFD1D1D6);
  static const Color topWidgetGradient2ndColor = Color(0xFF16548D);

  // Primary is thickest, secondary is subtitle, accent label text and 16548D fourth is mostly hint text
  static const Color primaryText = Color(0xFF091930);
  static const Color secondaryText = Color(0xFF82898F);
  static const Color accentText = Color(0xFF4D4D4D);
  static const Color fourthText = Color(0xFF878785);

  static const Color primaryDarkText = Color(0xFF091930);
  static const Color secondaryDarkText = Color(0xFF82898F);
  static const Color accentDarkText = Color(0xFF4D4D4D);
  static const Color fourthDarkText = Color(0xFF878785);

  // These colors should be same since they are similar
  static const Color primaryButton = Color(0xFF17568B);
  static const Color secondaryButton = Color(0xFF2E7DF1);
  static const Color disabledButton = Color(0xFF989EB0);

  static const Color primaryDarkButton = Color(0xFF17568B);
  static const Color secondaryDarkButton = Color(0xFF2E7DF1);
  static const Color disabledDarkButton = Color(0xFF989EB0);

  // Edit text bg
  static const Color editTextBg = Color(0xFFF7F7F7);
  static const Color editTextBgDark = Color(0xFFF7F7F7);

  static const Color editTextFocusedBg = Color(0xFFFFFFFF);
  static const Color editTextFocusedBgDark = Color(0xFFFFFFFF);

  static const Color editTextFocusedBorder = Color(0xFF2E7DF1);
  static const Color editTextFocusedBorderDark = Color(0xFF2E7DF1);

  static const Color editTextUnFocusedBorder = Color(0xFFFFFFFF);
  static const Color editTextUnFocusedBorderDark = Color(0xFFFFFFFF);

  // Bottom Nav
  static const Color bottomNavBg = Color(0xFFFFFFFF);
  static const Color bottomNavBgDark = Color(0xFFFFFFFF);

  static const Color bottomNavIconSelected = Color(0xFF2E7DF1);
  static const Color bottomNavIconSelectedDark = Color(0xFF2E7DF1);

  static const Color bottomNavIconUnSelected = Color(0xFF292D32);
  static const Color bottomNavIconUnSelectedDark = Color(0xFF292D32);

  // Wallet/ATM Card Bg
  static const Color cardBg = Color(0xFF0F2A50);
  static const Color cardDarkBg = Color(0xFF0F2A50);

  // Divider color
  static const Color divider = Color(0xFF82898F);
  static const Color dividerDark = Color(0xFF82898F);

  // Toggle
  static const Color toggleInActive = Color(0xFFE8E8E8);
  static const Color toggleDarkInActive = Color(0xFFE8E8E8);

  static const Color toggleActive = Color(0xFF0F2A50);
  static const Color toggleDarkActive = Color(0xFF0F2A50);

  // Arrow up and down
  static const Color upTrendColor = Color(0xFF3CD382);
  static const Color upTrendBgColor = Color(0x2672CF80);

  static const Color downTrendColor = Color(0xFFEA544F);
  static const Color downTrendBgColor = Color(0xFFFDEDED);

  // Icons bg and filled/border color
  static const Color iconGreyBgColor = Color(0xFFEBEEF1);

  static const Color iconBlueColor = Color(0xFFA4CDF7);
  static const Color iconBlueBgColor = Color(0xFFF1F7FE);

  static const Color successColor = Color(0xFF7BDFBB);
  static const Color successBgColor = Color(0xFFEBFAF5);

  static const Color errorColor = Color(0xFFEF2D28);
  static const Color errorBgColor = Color(0xFFFDEDED);

  static const Color idCardBorderFocus = Color(0xFFA4CDF7);
  static const Color idCardBgFocus = Color(0xFFF1F7FE);
  static const Color borderBorder = Color(0xFFE2E4E5);

  //others
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF82898F);
  static const Color onboardPageActiveIndicator = Color(0xFF2E7DF1);
  static const Color onboardPageInActiveIndicator = Color(0xFFE0E0E0);
  static const Color fundWalletWidgetBgColor = Color(0xFFF1F7FE);
  static const Color dividerColor = Color(0xFFF5F6F6);
  static const Color defaultDarkText = Color(0xFF000000);
  static const Color txnLeadingColor = Color(0x2672CF80);
  static const Color backBtnColor = Color(0xFF030D45);
  static const Color backBtnBorderColor = Color(0xFFE8E8E8);
  static const Color notTileLdColor = Color(0xFFF1F7FE);
  static const Color splashBg = Color(0xFF17568B);
}

//100% — FF
//95% — F2
//90% — E6
//85% — D9
//80% — CC
//75% — BF
//70% — B3
//65% — A6
//60% — 99
//55% — 8C
//50% — 80
//45% — 73
//40% — 66
//35% — 59
//30% — 4D
//25% — 40
//20% — 33
//15% — 26
//10% — 1A
//5% — 0D
//0% — 00
