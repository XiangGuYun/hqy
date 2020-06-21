import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';
import '../../constant/Config.dart';
import '../../my_lib/extension/BaseExtension.dart';

///广告页
class ADPage extends StatelessWidget {
  final arguments;

  ADPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    return App(
      imgUrl: arguments['url'].toString(),
    );
  }
}

class App extends StatefulWidget {
  final String imgUrl;

  App({this.imgUrl});

  @override
  _AppState createState() => _AppState(imgUrl: imgUrl);
}

class _AppState extends State<App> {
  final String imgUrl;

  _AppState({this.imgUrl});

  var number = 4;
  var needPush = true;
  var imgFile;

  @override
  void initState(){
    super.initState();

    imgFile = File(Global.prefs.get(Config.TEMP_PATH).toString()+"/ad.jpg");
    Timer.periodic(1.seconds(), (t) {
      setState(() {
        number--;
      });
      if (number == 0 && needPush) {
        t.cancel();
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
