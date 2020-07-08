import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:frame_animate_widget/frame_animate_widget.dart';
import 'package:wobei/bean/Banner.dart';
import 'package:wobei/bean/BannerData.dart';
import 'package:wobei/bean/HomeIcon.dart';
import 'package:wobei/bean/HomeLabel.dart';
import 'package:wobei/bean/Location.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/common/OverScrollBehavior.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/System.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';
import 'package:wobei/page/home/HomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/me/MePage.dart';
import 'package:wobei/plugin/AmapPlugin.dart';

import '../my_lib/extension/BaseExtension.dart';

///主页
class ScaffoldPage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<ScaffoldPage> with BaseUtils {
  //子页面
  var navigationBarHeight = 48.0;
  var currentIndex = 0; //当前页面的索引值
  PageController _pageController;
  var pages;

  List<BannerData> bannerList = [];
  List<Widget> homeIconList = [];
  List<Widget> areaList = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//    setStatusBarColor(true, Colors.transparent);
    _pageController = PageController(initialPage: 0, keepPage: true);
    pages = [HomePage(), MePage(), LoginPage()];
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
                      return pages[0];
                      break;
                    case 1:
                      return pages[1];
                      break;
                    default:
                      return pages[2];
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
                    currentIndex == 0
                        ? 'assets/images/home_active.png'
                        : 'assets/images/home_normal.png',
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
                            ? 'assets/images/right_active.png'
                            : 'assets/images/right_normal.png',
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
                        ? 'assets/images/myself_active.png'
                        : 'assets/images/myself_normal.png',
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

  Future<bool> _requestPop() {
    if (System.currentTimeMillis() - exitTime > 2000) {
      "再按一次退出应用".toast();
      exitTime = System.currentTimeMillis();
    } else {
      System.exit();
    }
  }

}
