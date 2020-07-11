import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

///检测网络状态
class ConnectivityPage extends StatefulWidget {
  @override
  _ConnectivityPageState createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  StreamSubscription<ConnectivityResult> sub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听手机网络状态
    sub = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi) {
        print("当前是wifi网络");
      } else if (event == ConnectivityResult.mobile) {
        print('当前是移动流量网络');
      } else if (event == ConnectivityResult.none) {
        print('当前无网络');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //取消监听
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
