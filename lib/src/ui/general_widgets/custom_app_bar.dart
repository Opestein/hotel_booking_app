import 'dart:ui' as ui;

import 'package:hotel_booking_app/src/values/router.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/app_utilities.dart';
import 'package:hotel_booking_app/src/values/const.dart';
import 'package:hotel_booking_app/src/values/values.dart';

typedef _Callback();

class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {Key? key,
      this.useBackDropFilter = false,
      this.rowCrossAxisAlignment = CrossAxisAlignment.center,
      this.gradient,
      this.padding = EdgeInsets.zero,
      this.leadingWidget,
      this.titleWidget,
      this.titleColor,
      this.trailingWidget,
      this.title,
      this.trailing,
      this.onLeadingCallback,
      this.onTrailingCallback,
      this.height,
      this.color = Colors.transparent,
      this.iconColor,
      this.useTrailing = true,
      this.trailingOpacity = 1.0,
      this.putBottomHeight = true,
      this.bottomHeight = 16,
      this.topHeight = 0,
      this.firstSpacerWidth,
      this.secondSpacerWidth})
      : super(key: key);

  final double? firstSpacerWidth;
  final double? secondSpacerWidth;
  final bool useBackDropFilter;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final Gradient? gradient;
  final Color? iconColor;
  final Color? color;
  final Color? titleColor;
  final double? height;
  final EdgeInsets padding;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? trailingWidget;
  final String? title;
  final String? trailing;
  final _Callback? onLeadingCallback;
  final _Callback? onTrailingCallback;
  final bool useTrailing;
  final double trailingOpacity;
  final bool putBottomHeight;
  final double bottomHeight;
  final double topHeight;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: responsiveWidth(context, 100),
      padding: padding,
      height: height,
      child: Column(
        children: <Widget>[
          SafeArea(
            child: SizedBox(
              height: topHeight,
            ),
          ),
          Row(
            crossAxisAlignment: rowCrossAxisAlignment,
            children: <Widget>[
              GestureDetector(
                onTap: onLeadingCallback ?? () => pop(context: context),
                child: leadingWidget ??
                    (useBackDropFilter
                        ? ClipRect(
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY: 5.0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.45),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.arrow_back,
                            size: 26,
                          )),
              ),
              if (firstSpacerWidth == null)
                Spacer()
              else
                SizedBox(
                  width: firstSpacerWidth,
                ),
              titleWidget != null
                  ? titleWidget!
                  : title != null
                      ? Text(title!,
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: kBoldWeight,
                            color: (titleColor),
                          ))
                      : Container(),
              if (secondSpacerWidth == null)
                const Spacer()
              else
                SizedBox(
                  width: secondSpacerWidth,
                ),
              if (useTrailing)
                Opacity(
                    opacity: trailingOpacity,
                    child: trailingWidget != null || trailing != null
                        ? GestureDetector(
                            onTap: onTrailingCallback,
                            child: trailingWidget ?? Text(trailing!,
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            fontWeight: kSemiBoldWeight,
                                            color: theme.buttonTheme.colorScheme
                                                ?.primary)),
                          )
                        : leadingWidget ?? Icon(kBackIcon,
                                size: 18, color: Colors.transparent)),
            ],
          ),
          if (putBottomHeight)
            SizedBox(
              height: bottomHeight,
            ),
        ],
      ),
    );
  }
}
