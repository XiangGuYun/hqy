import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wobei/bean/Location.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';

///高德地图插件
class AmapPlugin{

  static const platform_amap = const EventChannel('com.hb.wobei.plugins/amap');

  static StreamSubscription _subscription;

  static startLocate(Function getInfo){
     _subscription = platform_amap.receiveBroadcastStream().listen((event) {
      var info = event.toString();
      if(info != null){
        var list = info.split('-');
        getInfo(Location(lat: list[0], lon: list[1],
            provinceName: list[2], cityName: list[3]));
      }
    }, onError: (err) {
      print('2------------------------------');
    }, onDone: () {
      print('3------------------------------');
    });
  }

  static stopLocate(){
    if(_subscription != null)
      _subscription.cancel();
  }


}