import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final Widget? desktopLayout;
  final Widget? tabletLayout;
  final Widget? phoneLayout;

  const LayoutWidget(
      {super.key, this.desktopLayout, this.tabletLayout, this.phoneLayout});

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static double get maxMobileWidth => 600;

  static double get tabletWidth => 600;

  static double get tabletHeight => 1000;

  static double get maxWidgetPlotWidth => 700;

  static double get maxButtonWidth => 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1200 &&
          MediaQuery.sizeOf(context).width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1200;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    var shortestSide = MediaQuery.sizeOf(context).shortestSide;
// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.

    if (isMobile(context)) {
      return phoneLayout!;
      // } else if (isTablet(context) && tabletLayout != null) {
      //   return tabletLayout!;
      // } else if (isDesktop(context) && desktopLayout != null) {
      //   return desktopLayout!;
    }
    return phoneLayout ?? const SizedBox();
  }
}
