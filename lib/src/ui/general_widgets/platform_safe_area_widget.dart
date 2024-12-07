import 'dart:io';

import 'package:flutter/cupertino.dart';

class PlatformSafeArea extends StatelessWidget {
  final Widget? child;
  final bool? left, top, right, bottom;
  final double? height, width;

  const PlatformSafeArea(
      {super.key,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.height,
      this.width,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        left: left ?? true,
        top: top ?? true,
        right: right ?? true,
        bottom: bottom ?? (Platform.isIOS ? false : true),
        child: child ??
            SizedBox(
              height: height,
              width: width,
            ));
  }
}
