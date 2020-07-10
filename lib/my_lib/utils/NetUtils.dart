import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/my_lib/utils/AppUtils.dart';
import 'package:wobei/my_lib/utils/SPUtils.dart';
import 'package:wobei/my_lib/utils/System.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';

import '../../constant/URL.dart';

///*****************************************************************************
/// 网络请求工具类
///*****************************************************************************
class NetUtils {
  ///---------------------------------------------------------------------------
  ///
  /// Post请求，对于数据节点是对象的，推荐调用此方法，
  /// 可配合ALT+L生成数据类（不包含code，msg，success）
  /// 
  /// url 接口名
  /// 
  /// parameters 传参
  /// 
  /// getResult 请求回调
  /// 
  ///---------------------------------------------------------------------------
  static void post(
      String url, Map<String, String> parameters, Function getResult,
      {handleBySelf = false, getBitmap = false}) async {
    //放置请求头参数
    var headers = Map<String, dynamic>();

    //获取包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //获取当前时间
    var currentTime = System.currentTimeMillis();
    //获取设备ID
    String deviceId;
    AppUtils.getDeviceId((id) {
      deviceId = id;
    });
    //生成md5加密数据
    var hbSign = _generateMd5('HB_ANDROID_USER${currentTime}1.5.0');
    headers['Hb-sign'] = hbSign;
    SPUtils.getString("token", (token) {
      if (token.toString().isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
        SPUtils.putString("token", token);
      }
    });
    //将md5数据放入请求头
    var options = Options(headers: headers);
    //将共同参数放入到map中
    parameters['c'] = 'HB_ANDROID_USER';
    parameters['d'] = Global.deviceId;
    parameters['t'] = currentTime.toString();
    parameters['v'] = '1.5.0';
    //获取响应结果
    Response response = await Dio().post(URL.BASE_URL + url,
        queryParameters: parameters, options: options);
    if ([4004, 4005, 15210].contains(response.data['code'])) {
      //对特定错误响应码进行处理
      _handleCode(response.data['code']);
      return;
    }
    if (!getBitmap) {
      print(json.encode(response.data));
      if (!handleBySelf) {
        if (response.data['success']) {
          getResult(response.data['code'], response.data['msg'],
              response.data['success'], response.data['data']);
        } else {
          ToastUtils.show(response.data['msg']);
        }
      } else {
        getResult(response.data['code'], response.data['msg'],
            response.data['success'], response.data['data']);
      }
    } else {
      print(json.encode(response));
    }
  }

  ///---------------------------------------------------------------------------
  /// Post请求 对于数据节点是数组的，推荐调用此方法，
  /// 可配合generate+JsonToDart生成数据类（需包含code，msg，success）
  ///---------------------------------------------------------------------------
  static void post1(
      String url, Map<String, String> parameters, Function getResult,
      {handleBySelf = false, getBitmap = false}) async {
    //放置请求头参数
    var headers = Map<String, dynamic>();

    //获取包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //获取当前时间
    var currentTime = System.currentTimeMillis().toString();
    //获取设备ID
    String deviceId;
    //生成md5加密数据
    var hbSign = _generateMd5('HB_ANDROID_USER${currentTime}1.5.0');
    headers['Hb-sign'] = hbSign;
    SPUtils.getString("token", (token) {
      if (token.toString().isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
        SPUtils.putString("token", token);
      }
    });

    //将md5数据放入请求头
    var options = Options(headers: headers);
    //将共同参数放入到map中
    parameters['c'] = 'HB_ANDROID_USER';
    parameters['d'] = Global.deviceId;
    parameters['t'] = currentTime;
    parameters['v'] = '1.5.0';

    parameters.forEach((s1, s2) {
      print("传参 $s1 $s2");
    });

    //获取响应结果
    Response response = await Dio().post(URL.BASE_URL + url,
        queryParameters: parameters, options: options);
    if ([4004, 4005, 15210].contains(response.data['code'])) {
      //对特定错误响应码进行处理
      _handleCode(response.data['code']);
      return;
    }
    if (!getBitmap) {
      print(json.encode(response.data));
      if (!handleBySelf) {
        if (response.data['success']) {
          getResult(response);
        } else {
          ToastUtils.show(response.data['msg']);
        }
      } else {
        getResult(response);
      }
    } else {
      print(json.encode(response));
    }
  }

  ///---------------------------------------------------------------------------
  /// 请求图片（验证码），尚未实现
  ///---------------------------------------------------------------------------
  static Future<Response> post2(String url, Map<String, String> parameters,
      {handleBySelf = false, getBitmap = false}) async {
    //放置请求头参数
    var headers = Map<String, dynamic>();

    //获取包信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //获取当前时间
    var currentTime = System.currentTimeMillis().toString();
    //获取设备ID
    String deviceId;
    //生成md5加密数据
    var hbSign = _generateMd5('HB_ANDROID_USER${currentTime}1.5.0');
    headers['Hb-sign'] = hbSign;
    SPUtils.getString("token", (token) {
      if (token.toString().isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
        SPUtils.putString("token", token);
      }
    });

    //将md5数据放入请求头
    var options = Options(headers: headers);
    //将共同参数放入到map中
    parameters['c'] = 'HB_ANDROID_USER';
    parameters['d'] = Global.deviceId;
    parameters['t'] = currentTime;
    parameters['v'] = '1.5.0';

    parameters.forEach((s1, s2) {
      print("传参 $s1 $s2");
    });

    //获取响应结果
    Response response = await Dio().post(URL.BASE_URL + url,
        queryParameters: parameters, options: options);
    if ([4004, 4005, 15210].contains(response.data['code'])) {
      //对特定错误响应码进行处理
      _handleCode(response.data['code']);
      return null;
    }
    if (!getBitmap) {
      print(json.encode(response.data));
      if (!handleBySelf) {
        if (response.data['success']) {
        } else {
          ToastUtils.show(response.data['msg']);
        }
      } else {}
    } else {
      print(json.encode(response));
    }
    return response;
  }

  ///---------------------------------------------------------------------------
  /// 处理特定错误码
  ///---------------------------------------------------------------------------
  static void _handleCode(code) {
    switch (code) {
      case '4004': //未登录

        break;
      case '4005': //未实名认证

        break;
      case '15210': //未设置密码

        break;
    }
  }

  ///---------------------------------------------------------------------------
  /// md5加密
  ///---------------------------------------------------------------------------
  static String _generateMd5(String data) {
    var content = Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
