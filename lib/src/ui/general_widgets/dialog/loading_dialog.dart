import 'package:hotel_booking_app/src/app.dart';
import 'package:hotel_booking_app/src/singleton_data.dart';
import 'package:hotel_booking_app/src/utils/ui_functions.dart';
import 'package:hotel_booking_app/src/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/values/values.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  Future<bool> onPop() {
    return Future.value(kDebugMode);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onPop(),
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: _buildDialogChild(context),
      ),
    );
  }

  Widget _buildDialogChild(BuildContext context) {
    return kCircularProgressIndicator();
  }
}
