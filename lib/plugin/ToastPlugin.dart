
import 'package:flutter/services.dart';

class ToastPlugin{

  static const platform = const MethodChannel('samples.flutter.io/common');

  static void toast(String text) async{
    Map<String, Object> map = {"text": text};
    await platform.invokeMethod('toast', map);
  }

}