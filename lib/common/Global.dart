import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wobei/my_lib/utils/AppUtils.dart';

class Global {

  static SharedPreferences prefs;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static String deviceId;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
    AppUtils.getDeviceId((id){
      deviceId = id;
    });
  }


}