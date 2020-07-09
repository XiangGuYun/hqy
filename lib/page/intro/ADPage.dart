import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/lesson/provider/ProviderTest.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';
import '../../constant/Config.dart';
import '../../my_lib/extension/BaseExtension.dart';

/// ***************************************************************************
/// 广告页
/// ***************************************************************************
class ADPage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<ADPage> with BaseUtils{

  /// 广告倒计时秒数
  var number = 3;
  /// 用于防止手动跳过广告后后再次执行自动跳过广告的标志位
  var needPush = true;
  /// 广告图
  var imgFile;

  @override
  void initState(){
    super.initState();
    imgFile = File(Global.cacheDir+"/ad.jpg");
    /// 执行倒计时任务
    Timer.periodic(1.seconds(), (task) {
      setState(() {
        number--;
      });
      if (number == 0 && needPush) {
        task.cancel();
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.HOME_PAGE, ModalRoute.withName(AppRoute.AD_PAGE));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.file(imgFile, fit: BoxFit.cover,).setSize(double.infinity, double.infinity),
        Container(
          alignment: Alignment.center,
          width: 60,
          height: 28,
          child: Text(
            '跳过广告${number}s',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: Color(0x88000000),
          ),
        ).setClipRRect(14).setAlign(Alignment.topRight).setGestureDetector(
            onTap: () {
          needPush = false;
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoute.HOME_PAGE, ModalRoute.withName(AppRoute.AD_PAGE));
        }).setPositioned(right: 20, top: 20)
      ],
    ).setSize(double.infinity, double.infinity));
  }
}
