/*
*  FavoritesFragment
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro Technologies Limited]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/custom_app_bar.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/custom_gesture_detector.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/platform_safe_area_widget.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';

import '../../../../layout_widget.dart';
import '../../../../values/values.dart';

class FavoritesFragment extends StatefulWidget {
  static String routeName = '/favoritesFragment';

  const FavoritesFragment({super.key});

  @override
  State<FavoritesFragment> createState() => _FavoritesFragmentState();
}

class _FavoritesFragmentState extends State<FavoritesFragment> {
  final List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onWidgetLoaded();
    });
  }

  onWidgetLoaded() {}

  @override
  void dispose() {
    super.dispose();
  }

  void _addFavorite(String hotel) {
    setState(() {
      favorites.add(hotel);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // final bool isDark = theme.brightness == Brightness.dark;

    return LayoutWidget(
      phoneLayout: PlatformSafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leadingWidget: 0.width,
              title: localise.favorites,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: appSettingsBloc.appSettings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        (snapshot.data?.hotelResponse.cidList ?? [])
                            .isNotEmpty) {
                      var data = snapshot.data?.hotelResponse.cidList ?? [];
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultLayoutPadding),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var item = data.elementAt(index);
                          var ratingCount = item.rating ?? 0.0;

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading:
                                  const Icon(Icons.hotel, color: Colors.blue),
                              title: Text(
                                item.title ?? '',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: kMediumWeight),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.address ?? '',
                                    style: theme.textTheme.bodySmall
                                        ?.copyWith(fontWeight: kMediumWeight),
                                  ),
                                  8.height,
                                  SizedBox(
                                    width: 80,
                                    child: Row(
                                      children: List.generate(5, (index) {
                                        IconData? icon;
                                        if (index < ratingCount.floor()) {
                                          icon = Icons.star; // Full star
                                        } else if (index < ratingCount) {
                                          icon = Icons.star_half; // Half star
                                        } else {
                                          icon =
                                              Icons.star_border; // Empty star
                                        }

                                        return Row(
                                          children: [
                                            Icon(
                                              icon,
                                              color: Colors.yellow,
                                              size: 13,
                                            ),
                                            2.width,
                                          ],
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                              trailing: StreamBuilder<AppSettings>(
                                  stream: appSettingsBloc.appSettings,
                                  builder: (context, snapshot) {
                                    bool isFavorited = snapshot.hasData
                                        ? (snapshot.data?.hotelResponse
                                                    .cidList ??
                                                [])
                                            .where((element) =>
                                                element.cid == item.cid)
                                            .isNotEmpty
                                        : false;

                                    return CustomGestureDetector(
                                      onTap: () {
                                        appSettingsBloc
                                            .removeFromFavorite(item.cid ?? '');
                                      },
                                      child: Icon(
                                        isFavorited
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.blue,
                                      ),
                                    );
                                  }),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text(localise.noFavorites),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
