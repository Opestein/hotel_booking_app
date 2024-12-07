/*
*  AccountFragment
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2024 [Buenro Technologies Limited]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/src/bloc/app_settings_bloc.dart';
import 'package:hotel_booking_app/src/model/app_settings.dart';
import 'package:hotel_booking_app/src/model/saved_locale.dart';
import 'package:hotel_booking_app/src/model/simple_list_title_model.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/custom_radio_list_tile_widget.dart';
import 'package:hotel_booking_app/src/ui/general_widgets/platform_safe_area_widget.dart';
import 'package:hotel_booking_app/src/values/languages.dart';
import 'package:hotel_booking_app/src/values/themes.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:hotel_booking_app/src/values/padding.dart';

import '../../../../layout_widget.dart';

class AccountFragment extends StatefulWidget {
  static String routeName = '/accountFragment';

  const AccountFragment({super.key});

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final PageController _controller = PageController();

  int selectedThemeIndex = -1;
  Locale? selectedLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      themeInit();
      languageInit();
    });
  }

  themeInit() async {
    var appSettings = await appSettingsBloc.fetchAppSettings();
    setState(() {
      selectedThemeIndex = appSettings.themeModeIndex;
    });
  }

  languageInit() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    var splitted = (appSettings.locale?.localeName ?? '').split('_');
    setState(() {
      selectedLocale = Locale(splitted.first, splitted.elementAt(1));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Guest'),
                subtitle: const Text('generic@buen.ro'),
              ),
              const Divider(),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.dark_mode),
                  title: Text(localise.theme),
                ),
                children: [
                  CustomRadioListWidget(
                      key: ValueKey(selectedThemeIndex),
                      initialSelectedIndex: selectedThemeIndex,
                      simpleListTitleModel: [
                        ...kAllHotelBookingThemeModeValues
                            .map((e) => SimpleListTitleModel(title: e.label))
                      ],
                      onClickCallback: (int isSelected) async {
                        selectedThemeIndex = isSelected;

                        await injector.handleOptionsChanged(injector.options!
                            .copyWith(
                                hotelBookingThemeMode:
                                    kAllHotelBookingThemeModeValues
                                        .elementAt(selectedThemeIndex)));
                        await appSettingsBloc.setThemeMode(
                            kAllHotelBookingThemeModeValues
                                .elementAt(selectedThemeIndex)
                                .index);

                        // Update the system status bar
                        ThemeData theme = Theme.of(SingletonData
                            .singletonData.navigationKey.currentState!.context);
                        final bool isDark = theme.brightness == Brightness.dark;

                        SystemChrome.setSystemUIOverlayStyle(isDark
                            ? SystemUiOverlayStyle.light
                            : SystemUiOverlayStyle.dark);
                      }),
                ],
              ),
              8.height,
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.language),
                  title: Text(localise.language),
                ),
                children: [
                  CustomRadioListWidget(
                      key: ValueKey(selectedThemeIndex),
                      initialSelectedIndex: selectedThemeIndex,
                      simpleListTitleModel: [
                        ...kAllHotelBookingLanguageValues
                            .map((e) => SimpleListTitleModel(title: e.label))
                      ],
                      onClickCallback: (int index) async {
                        selectedLocale = kAllHotelBookingLanguageValues
                            .elementAt(index)
                            .locale;

                        var hotelBookingLanguage =
                            kAllHotelBookingLanguageValues.firstWhere(
                                (element) =>
                                    element.locale.toString() ==
                                    selectedLocale.toString());

                        await injector.handleOptionsChanged(injector.options!
                            .copyWith(
                                hotelBookingLanguage: hotelBookingLanguage));
                        await appSettingsBloc.setLanguageLocale(
                            SavedLocale(localeName: selectedLocale.toString()));
                      }),
                ],
              ),
              8.height,
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.delete_forever_outlined,
                    color: Colors.red),
                title: Text(localise.clearFavorites),
                onTap: () => appSettingsBloc.clearAllFavorites(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
