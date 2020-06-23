import 'package:flutter/cupertino.dart';
import 'package:wobei/my_lib/utils/PathUtils.dart';
import 'package:wobei/my_lib/utils/StorageUtils.dart';

//////////////////
///管理所有配置信息
/////////////////
class Config{

  static const String TEST_IMG = 'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3321238736,733069773&fm=26&gp=0.jpg';
  static const String TEST_IMG1 = 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3882521289,1164860711&fm=26&gp=0.jpg';
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

  /**
   * 图片资源
   */
  static const String HE_CARD_PRICE = 'assets/images/hecard_price.png';
  static const String BACK_BLACK = 'assets/images/back_black.png';
  static const String CLOSE = 'assets/images/close.png';
  static const String DEFAULT_BG = 'assets/images/default_bg.png';
  static const String SETTINGS_WHITE = 'assets/images/settings_white.png';
  static const String MESSAGE_WHITE = 'assets/images/message_white.png';
  static const String ARC = 'assets/images/arc.png';
  static const String VIP = 'assets/images/vip.png';
  static const String RIGHT_EXCHANGE = 'assets/images/right_exchange.png';
  static const String RED_PACKET = 'assets/images/red_packet.png';
  static const String VIP_EXCHANGE = 'assets/images/vip_exchange.png';
  static const String DETAIL_HE_CARD = 'assets/images/detail_hecard.png';
  /**
   * 颜色资源
   */
  static const Color BLACK_393649 = Color(0xFF393649);
  static const Color BLACK_303133 = Color(0xFF303133);
  static const Color GREY_C9C8CD = Color(0xFFC9C8CD);
  static const Color GREY_A5A3AC = Color(0xFFA5A3AC);
  static const Color RED_B3926F = Color(0xFFB3926F);
  static const Color GOLD_FFE2C0 = Color(0xFFFFE2C0);


}