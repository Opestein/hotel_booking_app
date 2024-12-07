import 'package:flutter/services.dart';
import 'package:hotel_booking_app/src/app_config.dart';
import 'package:hotel_booking_app/src/values/options.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/values/enums.dart';

String? replacementUrlA;
String? replacementApiKey;
String? replacementPaymentPublicKey;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class HotelBookingApp<B> extends StatefulWidget {
  final void Function(BuildContext context, B bloc)? onDispose;
  final B Function(BuildContext context, B? bloc)? builder;
  final Widget child;
  final SettingOptions? options;

  static HotelBookingAppState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AppConfig>())!
        .hotelBookingAppState;
  }

  HotelBookingApp({
    Key? key,
    required this.child,
    this.options,
    this.builder,
    this.onDispose,
  }) : super(key: key);

  createState() => HotelBookingAppState<B>(options);
}

class HotelBookingAppState<B> extends State<HotelBookingApp<B>> {
  HotelBookingAppState(this.options);

  SettingOptions? options;
  B? bloc;
  Key? key = UniqueKey();

  PageController homePageCC = PageController();
  BottomNavItem bottomNavItem = BottomNavItem.home;

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) {
      bloc = widget.builder!(context, bloc);
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(context, bloc!);
    }
    homePageCC.dispose();
    super.dispose();
  }

  List<BottomNavItem> queue = [BottomNavItem.home];

  pop() {
    //check if there are items in the list
    if (queue.isEmpty) {
      _animateHomePageTo(BottomNavItem.home);
      return;
    }

    queue.removeLast();

    //check if there are items in the list
    if (queue.isEmpty) {
      return;
    }
    var item = queue.last;

    _animateHomePageTo(item);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  pushWithAnimation(BottomNavItem item, {bool pushToNewPage = true}) {
    if (queue.isNotEmpty && queue.last == item) {
      //if same item is clicked
      return;
    }

    queue.add(item);
    if (!pushToNewPage) {
      setState(() {
        bottomNavItem = item;
      });
      return;
    }

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    _animateHomePageTo(item);
  }

  _animateHomePageTo(BottomNavItem item) {
    homePageCC.jumpToPage(item.widgetListIndex);
    setState(() {
      bottomNavItem = item;
    });
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  handleOptionsChanged(SettingOptions newOptions) {
//    if (options.timeDilation != newOptions.timeDilation) {
//      timeDilationTimer?.cancel();
//      timeDilationTimer = null;
//      if (newOptions.timeDilation > 1.0) {
//        // We delay the time dilation change long enough that the user can see
//        // that UI has started reacting and then we slam on the brakes so that
//        // they see that the time is in fact now dilated.
//        timeDilationTimer = Timer(const Duration(milliseconds: 150), () {
//          timeDilation = newOptions.timeDilation;
//        });
//      } else {
//        timeDilation = newOptions.timeDilation;
//      }
//    }
    setState(() {
      options = newOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppConfig(
      bloc: bloc,
      key: key,
      hotelBookingAppState: this,
      child: widget.child,
    );
  }
}
