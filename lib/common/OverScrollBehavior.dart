import 'dart:io';

import 'package:flutter/material.dart';

///
///这个类用于当滑动组件滑到边缘时，禁用蓝色贝塞尔曲线动画
///
class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if(Platform.isAndroid||Platform.isFuchsia){
      return child;
    }else{
      return super.buildViewportChrome(context,child,axisDirection);
    }
  }
}