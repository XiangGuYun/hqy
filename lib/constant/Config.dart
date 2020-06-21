import 'package:flutter/cupertino.dart';
import 'package:wobei/my_lib/utils/PathUtils.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';

//////////////////
///管理所有配置信息
/////////////////
class Config{

  //当前设备的缓存路径
  static const String TEMP_PATH = "TEMP_PATH";
  //黑色按钮背景色
  static const Color BTN_ENABLE_TRUE = Color(0xff303133);
  //黑色按钮按下后的背景色
  static const Color BTN_TAP_DOWN = Color(0x66303133);
  //禁用按钮背景色
  static const Color BTN_ENABLE_FALSE = Color(0xff909399);
  //分割线颜色
  static const Color DIVIDER_COLOR = Color(0xffedecee);

  static const String HE_CARD_PRICE = 'assets/images/hecard_price.png';

  static const String BACK_BLACK = 'assets/images/back_black.png';
  static const String CLOSE = 'assets/images/close.png';

}