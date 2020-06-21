import 'package:flutter/services.dart';

class System{

  ///获取当前的毫秒数（从1970年1月1日开始）
  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  ///退出应用程序
  static void exit() async{
    await _pop();
  }

  static Future<void> _pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

}