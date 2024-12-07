/*
*  DashboardFragment
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro Technologies Limited]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/custom_app_bar.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/custom_material_button.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/platform_safe_area_widget.dart';
import 'package:hotel_booking_app/src/values/assets.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:hotel_booking_app/src/values/font.dart';
import 'package:hotel_booking_app/src/values/padding.dart';

import '../../../../layout_widget.dart';

class DashboardFragment extends StatefulWidget {
  static String routeName = '/accountFragment';

  const DashboardFragment({super.key});

  @override
  State<DashboardFragment> createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<String> hotelImages = [
    Assets.hotel_sample_1_jpg,
    Assets.hotel_sample_2_jpg,
    Assets.hotel_sample_3_jpg,
    Assets.hotel_sample_4_jpg,
    Assets.hotel_sample_5_jpg,
    Assets.hotel_sample_6_jpg,
    Assets.hotel_sample_7_jpg,
    Assets.hotel_sample_8_jpg,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  openDrawer() {
    _globalKey.currentState!.openEndDrawer();
  }

  Future<bool> _onPop() => Future.value(false);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // final bool isDark = theme.brightness == Brightness.dark;

    return LayoutWidget(
      phoneLayout: PlatformSafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          child: Column(
            children: [
              CustomAppBar(
                leadingWidget: 0.width,
                title: localise.dashboardTitle,
              ),
              GridView.builder(
                itemCount: hotelImages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final hotel = hotelImages.elementAt(index);
                  return _buildCard(hotel);
                },
              ),
              16.height,
              CustomMaterialButton(
                onPressed: () {
                  injector.pushWithAnimation(BottomNavItem.hotel);
                },
                child: Text(localise.exploreHotels),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
