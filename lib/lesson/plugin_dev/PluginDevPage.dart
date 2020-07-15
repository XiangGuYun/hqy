import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';

class PluginDevPage extends StatefulWidget {
  @override
  _PluginDevPageState createState() => _PluginDevPageState();
}

class _PluginDevPageState extends State<PluginDevPage> {
  //首先，我们构建通道。我们使用MethodChannel调用一个方法来返回电池电量。
  //通道的客户端和宿主通过通道构造函数中传递的通道名称进行连接。
  //单个应用中使用的所有通道名称必须是唯一的;
  //我们建议在通道名称前加一个唯一的“域名前缀”，例如samples.flutter.io/battery
  static const platform = const MethodChannel('samples.flutter.io/common');
  static const platform1 =
      const MethodChannel('com.mrper.framework.plugins/toast');
  static const platform_amap = const EventChannel('com.hb.wobei.plugins/amap');

  String _batteryLevel = 'Unknown battery level.';

  //我们调用通道上的方法，指定通过字符串标识符调用方法getBatteryLevel。
  //该调用可能失败(平台不支持平台API，例如在模拟器中运行时)，
  //所以我们将invokeMethod调用包装在try-catch语句中
  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  void logD(String tag, String text){
    platform.invokeMethod('logD', {'text': tag, 'text': text});
  }

  Future<Null> _goToSecondActivity() async {
    String batteryLevel;
    try {
      await platform.invokeMethod('goToSecondActivity');
    } on PlatformException catch (e) {
      print("Failed to goToSecondActivity: '${e.message}'.");
    }
  }

  Future<Null> _reqPermission() async {
    try {
      await platform.invokeMethod('reqPermission', (lon, lat) {
        ToastUtils.show("$lat $lon");
      });
    } on PlatformException catch (e) {
      print("Failed to reqPermission: '${e.message}'.");
    }
  }

  Future<Null> _toast(String text) async {
    try {
      await platform.invokeMethod('toast', {'text': 'Hello Android'});
//      await platform1.invokeMethod('showShortToast', { 'message': text}); //调用相应方法，并传入相关参数。;
    } on PlatformException catch (e) {
      print("Failed to reqPermission: '${e.message}'.");
    }
  }

  StreamSubscription _subscription = null;

  @override
  void initState() {
    super.initState();
    _subscription = platform_amap.receiveBroadcastStream().listen((event) {
      print(event.toString());
    }, onError: (err) {
      print('2------------------------------');
    }, onDone: () {
      print('3------------------------------');
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消监听
    if (_subscription != null) {
      _subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    //最后，我们在build创建包含一个小字体显示电池状态和一个用于刷新值的按钮的用户界面。
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: () {},
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
