import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/System.dart';
import 'package:wobei/page/home/HomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/me/MePage.dart';

import '../my_lib/extension/BaseExtension.dart';

///主页
class ScaffoldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with BaseUtils {
  //子页面
  var pages = [HomePage(), MePage(), LoginPage()];
  var navigationBarHeight = 48.0;

  var currentIndex = 0; //当前页面的索引值

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
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
            PageView(
              children: pages,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
            ).setExpanded(1),
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
                  _pageController.jumpToPage(0);
                  setState(() {
                    currentIndex = 0;
                  });
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
                      _pageController.jumpToPage(1);
                      setState(() {
                        currentIndex = 1;
                      });
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
                  _pageController.jumpToPage(2);
                  setState(() {
                    currentIndex = 2;
                  });
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
