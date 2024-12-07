import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/custom_nav_bar_with_indicator/custom_nav_bar.dart';
import 'package:hotel_booking_app/src/utils/custom_nav_bar_with_indicator/custom_nav_bar_item.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';

import '../../../../values/values.dart';

typedef OnDrawerClickCallback = Function();
typedef OnPageSwitchCallback = Function(int index);

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({super.key});

  @override
  _BottomNavWidgetState createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // onWidgetLoaded();
    });
  }

  // onWidgetLoaded() {
  //   setState(() {
  //     selectedIndex = widget.index;
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onPop() => Future.value(false);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.

    final bool useMobileLayout = shortestSide < 600;
    final bool useTabletLayout = (shortestSide >= 600 && shortestSide < 1200);
    final bool usePCLayout = (shortestSide >= 1200);

    BottomNavItem selectedIndex = context.injector.bottomNavItem;

    return
        // useMobileLayout
        //   ?
        AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: Platform.isIOS ? 114 : 90,
      decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor,
          border: const Border(top: BorderSide(color: AppColors.grey))),
      child: Theme(
        data: theme.copyWith(splashColor: AppColors.primaryElement),
        child: CustomNavBarWithIndicator(
          key: UniqueKey(),
          onTap: (int index) {
            _switchScreen(index);
          },
          currentIndex: selectedIndex.widgetListIndex,
          items: [
            CustomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(Icons.home,
                    size: 24,
                    color: selectedIndex == BottomNavItem.home
                        ? theme.bottomNavigationBarTheme.selectedItemColor
                        : theme.bottomNavigationBarTheme.unselectedItemColor),
              ),
              leadingWidget: Text(localise.home,
                  style: selectedIndex == BottomNavItem.home
                      ? theme.bottomNavigationBarTheme.selectedLabelStyle
                      : theme.bottomNavigationBarTheme.unselectedLabelStyle),
            ),
            CustomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(Icons.hotel,
                    size: 24,
                    color: selectedIndex == BottomNavItem.hotel
                        ? theme.bottomNavigationBarTheme.selectedItemColor
                        : theme.bottomNavigationBarTheme.unselectedItemColor),
              ),
              leadingWidget: Text(localise.hotel,
                  style: selectedIndex == BottomNavItem.hotel
                      ? theme.bottomNavigationBarTheme.selectedLabelStyle
                      : theme.bottomNavigationBarTheme.unselectedLabelStyle),
            ),
            CustomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(Icons.favorite,
                    size: 24,
                    color: selectedIndex == BottomNavItem.favorites
                        ? theme.bottomNavigationBarTheme.selectedItemColor
                        : theme.bottomNavigationBarTheme.unselectedItemColor),
              ),
              leadingWidget: Text(localise.favorites,
                  style: selectedIndex == BottomNavItem.favorites
                      ? theme.bottomNavigationBarTheme.selectedLabelStyle
                      : theme.bottomNavigationBarTheme.unselectedLabelStyle),
            ),
            CustomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(Icons.person,
                    size: 24,
                    color: selectedIndex == BottomNavItem.account
                        ? theme.bottomNavigationBarTheme.selectedItemColor
                        : theme.bottomNavigationBarTheme.unselectedItemColor),
              ),
              leadingWidget: Text(localise.account,
                  style: selectedIndex == BottomNavItem.account
                      ? theme.bottomNavigationBarTheme.selectedLabelStyle
                      : theme.bottomNavigationBarTheme.unselectedLabelStyle),
            ),
          ],
        ),
      ),
    );
  }

  _switchScreen(int pos) {
    var provider = context.injector;
    BottomNavItem bottomNavItem = provider.bottomNavItem;

    if (provider.bottomNavItem.widgetListIndex == pos) {
      return;
    }

    switch (pos) {
      case 0:
        if (bottomNavItem.widgetListIndex == pos) {
          return;
        }

        // updateBottomItem(BottomNavItem.home);
        //break;
        provider.pushWithAnimation(BottomNavItem.home);

        break;

      case 1:
        provider.pushWithAnimation(BottomNavItem.hotel);

        break;

      case 2:
        provider.pushWithAnimation(BottomNavItem.favorites);

        break;
      case 3:
        provider.pushWithAnimation(BottomNavItem.account);
        break;
    }
  }

  updateBottomItem(BottomNavItem item) {
    injector.pushWithAnimation(item);
  }
}
