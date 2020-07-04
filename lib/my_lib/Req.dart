import 'package:dio/dio.dart';
import 'package:wobei/bean/Banner.dart';
import 'package:wobei/bean/LoginData.dart';
import 'package:wobei/constant/URL.dart';
import 'package:wobei/my_lib/utils/NetUtils.dart';

///管理所有的接口请求
class Req {
  ///获取广告页
  static void getADInfo() {
    NetUtils.post(URL.GUANG_GAO_YE_HUO_QU_TU_PIAN_DI_ZHI, Map()..['port'] = '1',
        (code, msg, success, data) {});
  }

  ///登录
  static void login(
      isPasswordLogin, phone, password, verificationCode, Function callback) {
    var params = Map<String, String>();
    params['phone'] = phone;
    if (isPasswordLogin) {
      params['password'] = password;
    } else {
      params['verificatCode'] = verificationCode;
    }
    params.forEach((k, v){
      print('HTTP: Key is $k, Value is $v');
    });
    NetUtils.post(URL.REGISTER, params, (c, m, s, d) {
      var data = LoginData.fromJson(d);
      callback(data);
    });
  }

  ///获取图片验证码
  static void getPicVerificationCode() {}

  ///获取轮播栏的信息
  static Future<Response> getBannerInfo({isHomePage = true}) async {
    var params = Map<String, String>();
    if (isHomePage) {
      params['position'] = "1";
    } else {
      params['position'] = "2";
    }
    params['port'] = '3';
    return  await NetUtils.post2(URL.LUN_BO_TU, params);
  }
}
