/*
*  Emurgo
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2023 [Emurgo]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/model/simple_list_title_model.dart';
import 'package:hotel_booking_app/src/values/extensions.dart';
import 'package:hotel_booking_app/src/values/values.dart';

typedef OnClickCallback(int indexSelected);

class CustomRadioListWidget extends StatefulWidget {
  final int initialSelectedIndex;
  final List<SimpleListTitleModel> simpleListTitleModel;
  final OnClickCallback onClickCallback;

  const CustomRadioListWidget(
      {super.key,
      this.initialSelectedIndex = -1,
      required this.onClickCallback,
      required this.simpleListTitleModel});

  @override
  State<StatefulWidget> createState() => CustomRadioListWidgetState();
}

class CustomRadioListWidgetState extends State<CustomRadioListWidget> {
  late List<SimpleListTitleModel> simpleListTitleModel =
      widget.simpleListTitleModel;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The

// number 600 here is a common breakpoint for a typical
// 7-inch tablet.

    final bool useMobileLayout = shortestSide < 600;

    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: simpleListTitleModel.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              margin: EdgeInsets.only(
                  top: (index == 0) ? 0 : 4,
                  bottom: index == (simpleListTitleModel.length - 1) ? 0 : 4),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: Radii.k4pxRadius,
                  border: Border.all(color: theme.dividerColor, width: 1)),
              child: Row(
                children: [
                  Radio(
                    groupValue: selectedIndex,
                    value: index,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: theme.toggleButtonsTheme.color,
                    onChanged: (int? value) {
                      onTap(index);
                    },
                  ),
                  if (simpleListTitleModel.elementAt(index).childBuilder ==
                      null)
                    8.width,
                  if (simpleListTitleModel.elementAt(index).childBuilder ==
                      null)
                    Text(
                      simpleListTitleModel.elementAt(index).title ?? '',
                      style: theme.textTheme.titleSmall!.copyWith(),
                    )
                  else
                    Expanded(
                      child: simpleListTitleModel
                          .elementAt(index)
                          .childBuilder!(context, index),
                    )
                ],
              ),
            ),
          );
        });
  }

  onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onClickCallback(selectedIndex);
  }
}
