import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/app_utilities.dart';
import 'package:hotel_booking_app/src/utils/custom_nav_bar_with_indicator/custom_nav_bar_item.dart';
import 'package:hotel_booking_app/src/values/values.dart';

class CustomNavBarWithIndicator extends StatefulWidget {
  final Curve curve;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveStripColor;
  final Color? indicatorColor;
  final bool useIndicator;
  final bool enableShadow;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomNavigationBarItem> items;

  const CustomNavBarWithIndicator({
    super.key,
    this.curve = Curves.linear,
    required this.onTap,
    required this.items,
    this.activeColor,
    this.inactiveColor,
    this.inactiveStripColor,
    this.indicatorColor,
    this.useIndicator = true,
    this.enableShadow = false,
    this.currentIndex = 0,
  }) : assert(items.length >= 2 && items.length <= 5);

  @override
  State createState() => _CustomNavBarWithIndicatorState();
}

class _CustomNavBarWithIndicatorState extends State<CustomNavBarWithIndicator> {
  late int currentIndex = widget.currentIndex;

  static const double kIndicatorHeight = 1;

  Curve get curve => widget.curve;

  List<CustomNavigationBarItem> get items => widget.items;

  double width = 0;
  late Color activeColor;
  Duration duration = const Duration(milliseconds: 270);

  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr) {
      return lerpDouble(-1.0, 1.0, index / (items.length - 1)) ?? 0.0;
    } else {
      return lerpDouble(1.0, -1.0, index / (items.length - 1)) ?? 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ??
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
        Theme.of(context).indicatorColor;

    return SizedBox(
      width: width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: kIndicatorHeight,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => _select(index),
                  child: ColoredBox(
                      color: Colors.transparent,
                      child:
                          _buildItemWidget(item, index == currentIndex, index)),
                );
              }).toList(),
            ),
          ),
          if (widget.useIndicator && currentIndex >= 0)
            Positioned(
              top: 0,
              width: width,
              child: AnimatedAlign(
                alignment: Alignment(_getIndicatorPosition(currentIndex), 0),
                curve: curve,
                duration: duration,
                child: Container(
                  width: (width / items.length) - safeAreaWidth(context, 3),
                  height: kIndicatorHeight + .5,
                  decoration: BoxDecoration(
                      color: widget.indicatorColor ?? activeColor,
                      borderRadius: Radii.k30pxRadius),
                  margin: EdgeInsets.symmetric(
                      horizontal: safeAreaWidth(context, 1)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  _select(int index) {
    currentIndex = index;
    widget.onTap(currentIndex);

    setState(() {});
  }

  Widget _buildIcon(CustomNavigationBarItem item, int index) {
    if (item.icon != null) return item.icon!;

    return Container();
  }

  Widget _buildTitle(CustomNavigationBarItem item, int index) {
    return DefaultTextStyle.merge(
      child: item.leadingWidget,
      style: TextStyle(
          color: currentIndex == index ? activeColor : widget.inactiveColor,
          fontWeight: currentIndex == index ? kBoldWeight : kRegularWeight),
    );
  }

  Widget _buildItemWidget(
      CustomNavigationBarItem item, bool isSelected, int index) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: item.backgroundColor ?? theme.navigationBarTheme.backgroundColor,
      width: width / items.length,
      child: Column(
        children: <Widget>[
          _buildIcon(item, index),
          _buildTitle(item, index),
        ],
      ),
    );
  }
}
