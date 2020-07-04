import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/bean/AdData.dart';
import 'package:wobei/constant/URL.dart';
import 'package:wobei/my_lib/utils/PathUtils.dart';
import 'package:wobei/my_lib/utils/NetUtils.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';
import 'package:wobei/my_lib/utils/System.dart';

///启动页
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    //隐藏状态栏
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //判断是否需要跳转广告页
    var time1 = System.currentTimeMillis();
    //获取广告页数据
    NetUtils.post(URL.GUANG_GAO_YE_HUO_QU_TU_PIAN_DI_ZHI, Map()..['port'] = '1',
        (code, msg, success, data) {
      var time2 = System.currentTimeMillis();
      //保证在广告页停留2秒
      Future.delayed(Duration(milliseconds: 2000 - (time2 - time1)), () {
        if (success) {
          var _data = AdData.fromJson(data);
          if (_data.isHave) {
            //如果有广告
            PathUtils.getTempPath().then((path) {
              //记录缓存地址
              StorageUtils.set(Config.TEMP_PATH, path);
              File('${path}/ad.jpg').exists().then((exists) {
                if (!exists) {
                  //如果广告图不存在则下载到缓存路径，然后跳转广告页
                  Dio()
                      .download(_data.imageUrl, '$path/ad.jpg')
                      .then((response) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoute.AD_PAGE,
                        ModalRoute.withName(AppRoute.WELCOME_PAGE),
                        arguments: {'path': path});
                  });
                } else {
                  //直接跳转广告页
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoute.AD_PAGE,
                      ModalRoute.withName(AppRoute.WELCOME_PAGE),
                      arguments: {'path': path});
                }
              });
            });
          } else {
            //如果没有广告则直接跳转主页
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoute.HOME_PAGE, ModalRoute.withName(AppRoute.WELCOME_PAGE));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/welcome.png",
        fit: BoxFit.cover,
      ),
    ));
  }
}
