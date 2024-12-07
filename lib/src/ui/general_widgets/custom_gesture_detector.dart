import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector(
      {super.key, this.child, this.padding, this.onTap});

  final Widget? child;
  final EdgeInsets? padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: padding,
        child: child,
      ),
    );
  }
}
