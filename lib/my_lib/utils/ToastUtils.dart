import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void show(String msg,
      {length = Toast.LENGTH_SHORT, gravity = ToastGravity.CENTER}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: gravity,
      timeInSecForIos: 1,
//        backgroundColor: Colors.grey,
//        textColor: Colors.white,
//        fontSize: 16
    );
  }
}
