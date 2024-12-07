import 'package:hotel_booking_app/src/ui/home_screen/widgets/account_fragment/account_fragment.dart';
import 'package:hotel_booking_app/src/ui/home_screen/widgets/common/bottom_nav.dart';
import 'package:hotel_booking_app/src/ui/home_screen/widgets/dashboard_fragment/dashboard_fragment.dart';
import 'package:hotel_booking_app/src/ui/home_screen/widgets/favorites_fragment/favorites_fragment.dart';
import 'package:hotel_booking_app/src/ui/home_screen/widgets/hotel_fragment/hotel_fragment.dart';
import 'package:hotel_booking_app/src/values/enums.dart';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';

const itemWidth = 60.0;

typedef OnDrawerClickCallback();
typedef OnPageSwitchCallback(int index);

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      onWidgetLoaded();
    });
  }

  onWidgetLoaded() {}

  openNotifications() {
    // _globalKey.currentState!.openEndDrawer();
    // routeToPage(
    //   child: const NotificationPage(),
    //   routeName: NotificationPage.routeName,
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  final widgetList = const [
    DashboardFragment(),
    HotelFragment(),
    FavoritesFragment(),
    AccountFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _body,
        bottomNavigationBar: const BottomNavWidget(),
      ),
    );
  }

  Widget get _body {
    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          // _controller.reset();
          // _controller.forward();
        },
        controller: injector.homePageCC,
        itemCount: widgetList.length,
        itemBuilder: (context, index) =>
            // FadeThroughTransition(
            //       animation: _controller,
            //       secondaryAnimation: _controller2,
            //       child:
            widgetList.elementAt(index)
        // ),
        );
  }
}
