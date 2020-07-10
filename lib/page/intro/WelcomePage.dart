import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/bean/AdData.dart';
import 'package:wobei/constant/URL.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/PathUtils.dart';
import 'package:wobei/my_lib/utils/NetUtils.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';
import 'package:wobei/my_lib/utils/System.dart';

///*****************************************************************************
///
/// 启动页
///
///*****************************************************************************
class WelcomePage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<WelcomePage> with BaseUtils {
  @override
  void initState() {
    super.initState();
    hideStatusBar(); //隐藏状态栏
    _reqAdData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        Config.WELCOME,
        fit: BoxFit.cover,
      ),
    ));
  }

  /// --------------------------------------------------------------------------
  /// 获取广告页数据
  /// --------------------------------------------------------------------------
  void _reqAdData() {
    var time1 = System.currentTimeMillis();
    Req.getAdInfo((success, data) {
      var time2 = System.currentTimeMillis();
      //保证在广告页停留2秒
      Future.delayed(Duration(milliseconds: 2000 - (time2 - time1)), () {
        if (success) {
          doData(AdData.fromJson(data));
        }
      });
    });
  }

  /// --------------------------------------------------------------------------
  /// 处理广告接口数据
  /// --------------------------------------------------------------------------
  void doData(_data) {
    if (_data.isHave) {
      //如果有广告
      File('${Global.cacheDir}/ad.jpg').exists().then((exists) {
        if (!exists) {
          //如果广告图不存在则下载到缓存路径，然后跳转广告页
          Dio()
              .download(_data.imageUrl, '${Global.cacheDir}/ad.jpg')
              .then((response) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.AD_PAGE,
              ModalRoute.withName(AppRoute.WELCOME_PAGE),
            );
          });
        } else {
          //直接跳转广告页
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.AD_PAGE,
            ModalRoute.withName(AppRoute.WELCOME_PAGE),
          );
        }
      });
    } else {
      //如果没有广告则直接跳转主页
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoute.HOME_PAGE, ModalRoute.withName(AppRoute.WELCOME_PAGE));
    }
  }
}
