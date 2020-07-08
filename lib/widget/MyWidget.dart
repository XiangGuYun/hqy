import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';

class MyWidget{

  static Widget getBackArrow(){
    return  Image.asset(
      Config.BACK_BLACK,
      width: 24,
      height: 24,
    );
  }

}