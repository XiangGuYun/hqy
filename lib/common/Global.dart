import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frame_animate_widget/frame_animate_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/utils/AppUtils.dart';
import 'package:wobei/my_lib/utils/PathUtils.dart';

/// ***************************************************************************
///
/// 全局类
/// 预获取或保存一些全局数据
///
/// **************************************************************************
class Global {

  /// 共享配置
  static SharedPreferences prefs;

  static String token;

  /// 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// 设备ID
  static String deviceId;

  ///缓存目录
  static String cacheDir;

  /// 网络加载帧动画图片列表
  static List<String> netLoadingImgList;

  /// 下拉刷新动画图片列表
  static List<String> frameList;

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  
    token = prefs.getString('token');
    
    AppUtils.getDeviceId((id){
      deviceId = id;
    });

    PathUtils.getTempPath().then((path) {
      cacheDir = path;
    });

    frameList = [
      Config.S_01,
      Config.S_02,
      Config.S_03,
      Config.S_04,
      Config.S_05,
      Config.S_06,
      Config.S_07,
      Config.S_08,
      Config.S_09,
      Config.S_10,
      Config.S_11,
      Config.S_12,
      Config.S_13,
      Config.S_14,
      Config.S_15,
      Config.S_16,
      Config.S_17,
      Config.S_18,
      Config.S_19,
      Config.S_20,
      Config.S_21,
      Config.S_22,
      Config.S_23,
      Config.S_24,
      Config.S_25,
      Config.S_26,
      Config.S_27,
      Config.S_28,
      Config.S_29,
      Config.S_30,
      Config.S_31,
      Config.S_32,
      Config.S_33,
      Config.S_34,
      Config.S_35,
      Config.S_36,
    ];

    netLoadingImgList = [
      Config.L_01,
      Config.L_02,
      Config.L_03,
      Config.L_04,
      Config.L_05,
      Config.L_06,
      Config.L_07,
      Config.L_08,
      Config.L_09,
      Config.L_10,
      Config.L_11,
      Config.L_12,
      Config.L_13,
      Config.L_14,
      Config.L_15,
      Config.L_16,
      Config.L_17,
      Config.L_18,
      Config.L_19,
      Config.L_20,
      Config.L_21,
      Config.L_22,
      Config.L_23,
      Config.L_24,
      Config.L_25,
      Config.L_26,
      Config.L_27,
      Config.L_28,
      Config.L_29,
      Config.L_30,
      Config.L_31,
      Config.L_32,
      Config.L_33,
      Config.L_34,
      Config.L_35,
      Config.L_36,
      Config.L_37,
      Config.L_38,
      Config.L_39,
      Config.L_40,
      Config.L_41,
      Config.L_42,
      Config.L_43,
      Config.L_44,
      Config.L_45,
      Config.L_46,
      Config.L_47,
      Config.L_48,
    ];

  }


}