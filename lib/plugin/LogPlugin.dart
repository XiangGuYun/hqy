
import 'package:flutter/services.dart';

class LogPlugin{

  static const platform = const MethodChannel('samples.flutter.io/common');

  static void logD(String tag, String text) async{
    Map<String, Object> map = {"tag": tag, 'text': text};
    await platform.invokeMethod('logD', map);
  }

}