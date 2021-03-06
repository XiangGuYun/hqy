import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:wobei/bean/LoginData.dart';
import 'package:wobei/bean/MeData.dart';
import 'package:wobei/bean/MyCardData.dart';
import 'package:wobei/bean/SearchWord.dart';
import 'package:wobei/constant/URL.dart';
import 'package:wobei/my_lib/utils/DartUtils.dart';
import 'package:wobei/my_lib/utils/NetUtils.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';
import 'package:wobei/plugin/LogPlugin.dart';
import 'package:wobei/plugin/ToastPlugin.dart';

///*****************************************************************************
/// 管理所有的接口请求
///*****************************************************************************
class Req {
  ///---------------------------------------------------------------------------
  /// 登录
  ///---------------------------------------------------------------------------
  static void login(
      isPasswordLogin, phone, password, verificationCode, Function callback) {
    var params = Map<String, String>();
    params['phone'] = phone;
    if (isPasswordLogin) {
      params['password'] = password;
    } else {
      params['verificatCode'] = verificationCode;
    }
    params.forEach((k, v) {
      print('HTTP: Key is $k, Value is $v');
    });
    NetUtils.post(URL.REGISTER, params, (c, m, s, d) {
      var data = LoginData.fromJson(d);
      callback(data);
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取图片验证码
  ///---------------------------------------------------------------------------
  static Future<Uint8List> getPicVerificationCode(String phone) {
    return NetUtils.getBitmap(
        URL.VERIFY_PIC, Map<String, String>()..['phone'] = phone);
  }

  ///---------------------------------------------------------------------------
  /// 上传头像
  ///---------------------------------------------------------------------------
  static void uploadAvatar(File file, Function callback) {
    NetUtils.uploadImage(URL.UPLOAD_AVATAR, file, (c, m, s, d) {
      if (s) {
        ToastUtils.show('上传成功');
        callback(d['url']);
      } else {
        ToastUtils.show(m);
      }
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取轮播栏的信息
  ///---------------------------------------------------------------------------
  static Future<Response> getBannerInfo({isHomePage = true}) async {
    var params = Map<String, String>();
    if (isHomePage) {
      params['position'] = "1";
    } else {
      params['position'] = "2";
    }
    params['port'] = '3';
    return await NetUtils.post2(URL.LUN_BO_TU, params);
  }

  ///---------------------------------------------------------------------------
  /// 获取首页图标
  ///---------------------------------------------------------------------------
  static Future<Response> getHomeIcon() async {
    var params = Map<String, String>();
    return await NetUtils.post2(URL.HOME_ICON, params);
  }

  ///---------------------------------------------------------------------------
  ///
  /// ## 获取首页标签
  ///
  /// latitude 纬度
  ///
  /// longitude 经度
  ///
  /// cityId 城市ID
  ///
  ///---------------------------------------------------------------------------
  static Future<Response> getHomeLabel(
      String latitude, String longitude, String cityId) async {
    var params = Map<String, String>();
    params['cityId'] = '87'; //todo 先写死
    params['latitude'] = latitude;
    params['longitude'] = longitude;
    return await NetUtils.post2(URL.HOME_LABEL, params);
  }

  ///---------------------------------------------------------------------------
  /// 获取广告信息
  ///---------------------------------------------------------------------------
  static void getAdInfo(Function callback) {
    NetUtils.post(URL.GUANG_GAO_YE_HUO_QU_TU_PIAN_DI_ZHI, Map()..['port'] = '1',
        (code, msg, success, data) {
      callback(success, data);
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取搜索关键词
  ///---------------------------------------------------------------------------
  static Future<Response> getKeyword(Function callback) {
    NetUtils.post(URL.GET_SEARCH_WORDS, Map()..['port'] = '1', (c, m, s, d) {
      callback(SearchWord.fromJson(d));
    });
  }

  ///---------------------------------------------------------------------------
  ///
  /// 获取手机验证码
  ///
  /// verifyPictureCode 图片验证码
  ///
  ///---------------------------------------------------------------------------
  static void getVCode(String phone, Function callback,
      {String verifyPictureCode}) {
    Map params = Map<String, String>()..['phone'] = phone;
    if (verifyPictureCode != null) {
      params['verifyPictureCode'] = verifyPictureCode;
    }
    NetUtils.post(URL.SEND_MESSAGE, params, (c, m, s, d) {
      callback(d['token']);
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取“我的”信息
  ///---------------------------------------------------------------------------
  static void getMeInfo(Function callback) {
    Map params = Map<String, String>();
    NetUtils.post(URL.LOOKUP_DATA, params, (c, m, s, d) {
      callback(MeData.fromJson(d));
    });
  }

  ///---------------------------------------------------------------------------
  /// 实名认证
  ///---------------------------------------------------------------------------
  static void certification(
      String name, String idCard, Function success, Function failure) {
    Map params = Map<String, String>();
    params['name'] = name;
    params['idCard'] = idCard;
    NetUtils.post(URL.CERTIFICATION, params, (c, m, s, d) {
      if (d == true) {
        success(m);
      } else {
        failure(m);
      }
    });
  }

  ///---------------------------------------------------------------------------
  /// 修改我的信息
  ///---------------------------------------------------------------------------
  static void modifyMeInfo(Map<String, String> params, Function success) {
    NetUtils.post(URL.MODIFY_DATA, params, (c, m, s, d) {
      if (d == true) {
        success();
      } else {
        ToastUtils.show(m);
      }
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取我的权益卡券
  ///---------------------------------------------------------------------------
  static void getMyCard(Function callback) {
    Map params = Map<String, String>();
    NetUtils.post(URL.FEN_YE_LIST, params, (c, m, s, d) {
//      LogPlugin.logD('Test123', json.encode(d));
      callback(MyCardData.fromJson(d));
    });
  }

  ///---------------------------------------------------------------------------
  /// 获取我的企业信息
  ///---------------------------------------------------------------------------
  static void viewMyEnterpriseInfo(Function callback){
    Map params = Map<String, String>();
    NetUtils.post(URL.CHA_KAN_WO_DE_QI_YE_XIN_XI, params, (c, m, s, d) {
      if(d==null){
        callback(-1, '-1');
      } else {
        callback(d['customerId'], d['customerName']);
      }
    });
  }
}
