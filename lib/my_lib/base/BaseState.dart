import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseUtils {
  ///显示状态栏
  void showStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  ///隐藏状态栏
  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  ///获取状态栏高度
  double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }

  ///设置状态栏文字颜色和背景颜色
  ///isDark 文字和图标是否是深色
  ///statusBarColor 背景色
  void setStatusBarColor(bool isDark, Color statusBarColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: statusBarColor,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    ));
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}
