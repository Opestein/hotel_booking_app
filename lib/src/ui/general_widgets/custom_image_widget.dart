import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotel_booking_app/src/values/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUri;
  final String? placeholderUri;
  final String? errorUri;
  final Widget? placeholderWidget, errorWidget;
  final double? height, width;
  final BoxFit? fit;
  final Color? color;

  ///Use this to force a file type
  final CustomImageWidgetType type;

  const CustomImageWidget(
      {super.key,
      required this.imageUri,
      this.placeholderUri,
      this.errorUri,
      this.placeholderWidget,
      this.errorWidget,
      this.height,
      this.width,
      this.fit,
      this.color,
      this.type = CustomImageWidgetType.any});

  @override
  Widget build(BuildContext context) {
    if (imageUri.isNotEmpty) {
      if (imageUri.startsWith('http') || type == CustomImageWidgetType.url) {
        return CachedNetworkImage(
          imageUrl: imageUri,
          height: height,
          width: width,
          fit: fit,
          color: color,
          placeholder: (context, url) =>
              placeholderWidget ??
              Image.asset(
                placeholderUri ?? '',
                height: height,
                width: width,
                fit: fit,
                color: color,
              ),
          errorWidget: (context, url, e) =>
              errorWidget ??
              Image.asset(
                errorUri ?? '',
                height: height,
                width: width,
                fit: fit,
                color: color,
              ),
        );
      } else if (imageUri.startsWith('file') ||
          type == CustomImageWidgetType.file) {
        return Image.file(
          File(imageUri),
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
      } else if (type == CustomImageWidgetType.base64) {
        return Image.memory(
          base64.decode(imageUri),
          height: height,
          width: width,
          fit: fit,
          color: color,
        );
      } else if (imageUri.endsWith('.svg')) {
        return SvgPicture.asset(
          imageUri,
          height: height,
          width: width,
          fit: fit ?? BoxFit.contain,
          color: color,
        );
      }
      return Image.asset(
        imageUri,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    }
    return SizedBox(height: height, width: width);
  }
}
