import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/eventbus/EventBus.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/System.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';
import 'package:wobei/page/home/HomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/me/MePage.dart';

import '../my_lib/extension/BaseExtension.dart';

/// ***************************************************************************
///
/// App脚手架页面
/// 作用类似与Android中托管多个Fragment的Activity
///
/// ***************************************************************************
class ScaffoldPage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<ScaffoldPage> with BaseUtils {
  /// 子页面
  var navigationBarHeight = 48.0;

  /// 当前页面的索引值
  var currentIndex = 0;

  /// 翻页控制器
  PageController _pageController;

  /// 是否处于登录状态
  var isLogin = false;

  @override
  void initState() {
    super.initState();
//    showStatusBar();
    bus.on('Scaffold', (arg) {
      switch(arg){
        case 'login': // 登录
          setState(() {
            isLogin = true;
          });
          break;
        case 'unlogin': // 未登录
            setState(() {
              currentIndex = 2;
              isLogin = false;
              _pageController.jumpToPage(2);
            });
            break;
      }
    });
    setStatusBarColor(true, Colors.transparent);
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    bus.off('Scaffold');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        //防止键盘顶起底部组件
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            PageView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                //禁止左右滑动
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {},
                controller: _pageController,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return HomePage();
                      break;
                    case 1:
                      return MePage();
                      break;
                    default:
                      return isLogin ? MePage() : LoginPage();
                  }
                }).setExpanded(1),
            Divider(
              height: 1,
              color: Color(0xffeeeeee),
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: context.getSrnW() / 3,
                  height: navigationBarHeight,
                  alignment: Alignment.center,
                  child: Image.asset(
                    currentIndex == 0 ? Config.HOME_ACTIVE : Config.HOME_NORMAL,
                    width: 40,
                    height: 40,
                  ),
                ).setGestureDetector(onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                  _pageController.jumpToPage(0);
                }),
                GestureDetector(
                    child: Container(
                      color: Colors.white,
                      width: context.getSrnW() / 3,
                      height: navigationBarHeight,
                      alignment: Alignment.center,
                      child: Image.asset(
                        currentIndex == 1
                            ? Config.RIGHT_ACTIVE
                            : Config.RIGHT_NORMAL,
                        width: 40,
                        height: 40,
                      ),
                    ),
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                      _pageController.jumpToPage(1);
                    }),
                Container(
                  color: Colors.white,
                  width: context.getSrnW() / 3,
                  height: navigationBarHeight,
                  alignment: Alignment.center,
                  child: Image.asset(
                    currentIndex == 2
                        ? Config.MYSELF_ACTIVE
                        : Config.MYSELF_NORMAL,
                    width: 40,
                    height: 40,
                  ),
                ).setGestureDetector(onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                  _pageController.jumpToPage(2);
                }),
              ],
            ).setSizedBox(width: context.getSrnW(), height: navigationBarHeight)
          ],
        ),
      ),
    );
  }

  var exitTime = 0;

  ///---------------------------------------------------------------------------
  /// 连续双击退出应用
  ///---------------------------------------------------------------------------
  Future<bool> _requestPop() async {
    if (System.currentTimeMillis() - exitTime > 2000) {
      "再按一次退出应用".toast();
      exitTime = System.currentTimeMillis();
      return false;
    } else {
      System.exit();
      return true;
    }
  }
}
