import 'package:flutter/services.dart';

class SystemInputType {
  static void get hide =>
      SystemChannels.textInput.invokeMethod('TextInput.hide');

  static void get show =>
      SystemChannels.textInput.invokeMethod('TextInput.show');
}
