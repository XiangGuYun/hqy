import 'package:date_format/date_format.dart';
import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/widget/MyIndicator.dart';
import 'package:wobei/widget/MyTab.dart';
import '../my_lib/extension/BaseExtension.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _controller;
  TextStyle selectStyle, unSelectStyle;
  int currentIndex = 0;
  double fontSize1 = 18.0;
  double fontSize2 = 16.0;

  ///当组件销毁时调用
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectStyle = TextStyle(fontSize: 18, color: Config.BLACK_393649);
    unSelectStyle = TextStyle(fontSize: 16, color: Color(0xFFA5A3AC));
    _controller = TabController(vsync: this, length: 4);
    //监听Tab切换事件
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 44.0,
            child: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.only(left: 0, right: 24),
              controller: _controller,
              indicator:MyTabIndicator(
                borderSide: BorderSide(
                  width: 3,
                  color: Config.RED_B3926F
                )
              ),
              labelStyle: selectStyle,
              unselectedLabelStyle: unSelectStyle,
              tabs: <Widget>[
                MyTab(
                  text:"Tab1-新闻世界",
                  textColor: currentIndex==0?Config.BLACK_393649:Config.GREY_A5A3AC,
                ),
                MyTab(
                  text:"Tab2-动物世界",
                  textColor: currentIndex==1?Config.BLACK_393649:Config.GREY_A5A3AC,
                ),
                MyTab(
                  text:"Tab3-艺术天堂",
                  textColor: currentIndex==2?Config.BLACK_393649:Config.GREY_A5A3AC,
                ),
                MyTab(
                  text:"Tab4-悲惨世界",
                  textColor: currentIndex==3?Config.BLACK_393649:Config.GREY_A5A3AC,
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Center(
            child: Text("Tab1-新闻世界"),
          ),
          Center(
            child: Text("Tab2-花之舞"),
          ),
          Center(
            child: Text("Tab3-联系人"),
          ),
          Center(
            child: Text("Tab4-联系人"),
          ),
        ],
      ),
    );
  }
}
