import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/bean/LoginData.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/constant/URL.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/NetUtils.dart';
import 'package:wobei/my_lib/utils/SPUtils.dart';

import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
///
/// 登录页
///
///*****************************************************************************
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

///*****************************************************************************
///
/// 登录视图类型
///
///*****************************************************************************
enum ViewType {
  /// 密码登录
  PASSWORD_LOGIN,

  /// 验证码登录
  VERIFICATION_CODE_LOGIN,
}

class _AppState extends State<App>
    with BaseUtils, AutomaticKeepAliveClientMixin {
  /// 登录类型
  var viewType = ViewType.VERIFICATION_CODE_LOGIN;

  ///登录按钮颜色
  var buttonColor = Config.BTN_ENABLE_FALSE;

  ///用户输入的手机号码
  var valuePhoneNumber;

  ///用户输入的密码
  var valuePassword;

  ///用户输入的验证码
  var valueVerificationCode;

  ///是否以密码方式登录
  var isPasswordLogin = false;

  ///登录方式
  var loginMethod = '密码登录';

  ///“获取验证码”是否可见
  var getVerificationCodeVisible = true;

  ///“忘记密码”是否可见
  var forgetPasswordVisible = false;

  ///“未注册禾权益的账号，登录时将自动注册”是否可见
  var hintVisible = true;

  ///验证码（密码）输入框的提示文本
  var hintOfSecondTextField = '请输入验证码';

  ///验证码（密码）输入框可输入的最大长度
  var maxLengthOfSecondTextField = 4;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(true, Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      //防止键盘顶起底部组件
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: getStatusBarHeight()),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '登录',
                  style: TextStyle(
                    color: Color(0xff303133),
                    fontSize: 32,
                  ),
                ).setMargin1(top: 87),
                getInputArea(),
                SizedBox(
                  height: 1,
                ).setExpanded(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '登录即视为您同意',
                      style: TextStyle(fontSize: 12, color: Color(0xFFC0C4CC)),
                    ),
                    Text(
                      '《用户协议》',
                      style: TextStyle(fontSize: 12, color: Color(0xFF5C7099)),
                    ),
                    Text(
                      '和',
                      style: TextStyle(fontSize: 12, color: Color(0xFFC0C4CC)),
                    ),
                    Text(
                      '《隐私政策》',
                      style: TextStyle(fontSize: 12, color: Color(0xFF5C7099)),
                    ),
                  ],
                ).setPadding1(bottom: 20)
              ],
            ).setPadding1(left: 40, right: 40),
            Container(
              child: Image.asset(
                Config.CLOSE,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(left: 20, top: 10),
            )
          ],
        ),
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 获取输入视图(密码或验证码)
  ///---------------------------------------------------------------------------
  Widget getInputArea() {
    if (viewType == ViewType.VERIFICATION_CODE_LOGIN) {
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '86+',
                style: TextStyle(fontSize: 18, color: Color(0xFF303133)),
              ).setSizedBox(width: 56.5, height: 28),
              TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 18, color: Color(0xFF303133)),
                //监听输入事件
                onChanged: (value) {
                  valuePhoneNumber = value;
                  if (valuePassword.toString().length >= 6 &&
                      valuePhoneNumber.toString().length == 11) {
                    setState(() {
                      buttonColor = Config.BLACK_303133;
                    });
                  } else {
                    setState(() {
                      buttonColor = Config.BTN_ENABLE_FALSE;
                    });
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                ],
                cursorColor: Colors.black,
                //装饰
                decoration: InputDecoration(
                    //设置提示文字
                    hintText: "请输入手机号",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Color(0xFFC0C4CC)),
                    //设置边框
                    border: InputBorder.none //去除
                    ),
              )
                  .setSizedBox(width: context.getSrnW() - 136.5)
                  .setPadding1(bottom: 5),
            ],
          ).setMargin1(top: 38.5),
          Divider(
            height: 1,
            color: Color(0xFFDCDFE6),
          ),
          Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  TextField(
                    style: TextStyle(fontSize: 18, color: Color(0xFF303133)),
                    //监听输入事件
                    onChanged: (value) {
                      valuePassword = value;
                      if (valuePassword.toString().length >= 6 &&
                          valuePhoneNumber.toString().length == 11) {
                        setState(() {
                          buttonColor = Config.BLACK_303133;
                        });
                      } else {
                        setState(() {
                          buttonColor = Config.BTN_ENABLE_FALSE;
                        });
                      }
                    },
                    obscureText: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          maxLengthOfSecondTextField),
                    ],
                    cursorColor: Colors.black,
                    //装饰
                    decoration: InputDecoration(
                        //设置提示文字
                        hintText: hintOfSecondTextField,
                        hintStyle:
                            TextStyle(fontSize: 16, color: Color(0xFFC0C4CC)),
                        //设置边框
                        border: InputBorder.none //去除
                        ),
                  )
                      .setSizedBox(width: context.getSrnW() - 80)
                      .setPadding1(bottom: 5),
                  Positioned(
                    child: Text(
                      '获取验证码',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff909399),
                          fontWeight: FontWeight.w600),
                    ).setVisible2(getVerificationCodeVisible),
                    right: 0,
                    bottom: 18.5,
                  )
                ],
              )
            ],
          ).setMargin1(top: 16),
          Divider(
            height: 1,
            color: Color(0xFFDCDFE6),
          ),
          Text(
            '忘记密码？',
            style: TextStyle(color: Color(0xff303133), fontSize: 14),
          )
              .setAlign(Alignment.topRight)
              .setPadding1(top: 10)
              .setVisible2(forgetPasswordVisible),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              '登 录',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            color: buttonColor,
            width: context.getSrnW() - 80,
            height: 50,
            alignment: Alignment.center,
          ).setClipRRect(5).setGestureDetector(onTapDown: (details) {
            setState(() {
              buttonColor = Config.BTN_TAP_DOWN;
            });
          }, onTapUp: (details) {
            setState(() {
              buttonColor = Config.BLACK_303133;
            });
          }, onTap: () {
            if (buttonColor != Config.BLACK_303133) return;
            Req.login(isPasswordLogin, valuePhoneNumber, valuePassword,
                valueVerificationCode, (data) {
              if (data.token != '-1') {
                //第一次登录
                '验证码已发送'.toast();
                startCountDown();
              } else {
                //非第一次登录,弹出图片验证码对话框
                SPUtils.putString('token', data.token);
              }
            });
          }),
          SizedBox(
            height: 10,
          ),
          Text(
            '未注册禾权益的账号，登录时将自动注册',
            style: TextStyle(fontSize: 12, color: Color(0xffc0c4cc)),
          ).setVisible2(hintVisible),
          Text(
            loginMethod,
            style: TextStyle(color: Color(0xff303133), fontSize: 14),
          ).setAlign(Alignment.center).setPadding(20).setGestureDetector(
              onTap: () {
            setState(() {
              if (loginMethod == '验证码登录') {
                //登录方式变为验证码登录
                loginMethod = '密码登录';
                forgetPasswordVisible = false;
                hintOfSecondTextField = '请输入验证码';
                getVerificationCodeVisible = true;
                hintVisible = true;
              } else {
                //登录方式变为密码登录
                loginMethod = '验证码登录';
                forgetPasswordVisible = true;
                hintOfSecondTextField = '请输入密码';
                getVerificationCodeVisible = false;
                hintVisible = false;
              }
            });
          }),
        ],
      );
    } else if (viewType == ViewType.PASSWORD_LOGIN) {
      return Column(
        children: <Widget>[],
      );
    }
  }

  ///---------------------------------------------------------------------------
  /// 执行可再次获取验证码的倒计时
  ///---------------------------------------------------------------------------
  void startCountDown() {
    Timer.periodic(Duration(seconds: 1), (task) {});
  }

  @override
  bool get wantKeepAlive => true;
}
