import 'package:hotel_booking_app/src/utils/app_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/values/values.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton(
      {required this.onPressed,
      this.title = '',
      this.child,
      this.prefixIcon,
      this.suffixIcon,
      this.height = 55,
      this.color,
      this.useGradient = false,
      this.textColor,
      this.minWidth,
      this.borderRadius = Radii.k16pxRadius,
      this.elevation = 1,
      this.fontSize,
      this.showIcon = false});

  final Widget? child;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String title;
  final Function() onPressed;
  final double height;
  final Color? color;
  final bool useGradient;
  final Color? textColor;
  final double? fontSize;
  final BorderRadiusGeometry borderRadius;
  final double? minWidth;
  final double elevation;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var injector = HotelBookingApp.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          gradient: useGradient
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.5,
                    1,
                  ],
                  colors: [
                    AppColors.secondaryButton,
                    AppColors.primaryButton,
                  ],
                )
              : null,
          borderRadius: borderRadius,
          color: color ?? theme.buttonTheme.colorScheme?.primary,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        width: minWidth ?? safeAreaWidth(context, 100),
        height: height,
        child: child != null
            ? child
            : showIcon
                ? Row(
                    children: [
                      Spacer(),
                      if (prefixIcon != null)
                        prefixIcon!
                      else if (suffixIcon != null)
                        Opacity(opacity: 0, child: suffixIcon!),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        title,
                        style: theme.textTheme.labelMedium!.copyWith(
                            color: textColor ?? AppColors.white,
                            fontSize: fontSize),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      if (suffixIcon != null)
                        suffixIcon!
                      else if (prefixIcon != null)
                        Opacity(opacity: 0, child: prefixIcon!),
                      Spacer(),
                    ],
                  )
                : Text(
                    title,
                    style: theme.textTheme.labelLarge!.copyWith(
                        color: textColor ?? AppColors.white,
                        fontSize: fontSize,
                        fontWeight: kSemiBoldWeight),
                  ),
      ),
    );
  }
}
