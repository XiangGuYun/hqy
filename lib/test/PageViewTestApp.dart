import 'package:flutter/material.dart';

class PageViewTestApp extends StatefulWidget {
  @override
  _PageViewTestAppState createState() => _PageViewTestAppState();
}

class _PageViewTestAppState extends State<PageViewTestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Text("xxxxx"),
      ),
      body: PageView(
        //滚动方向,分为 Axis.horizontal 和 Axis.vertical。
        scrollDirection: Axis.horizontal,
        //反转，是否从最后一个开始算0
        reverse: false,
        controller: PageController(
          //初始化第一次默认在第几个页面。
          initialPage: 1,
          //占屏幕多少，1为占满整个屏幕
          viewportFraction: 1,
          //是否保存当前 Page 的状态，如果保存，下次回复对应保存的 page，initialPage被忽略，
          //如果为 false 。下次总是从 initialPage 开始。
          keepPage: true,
        ),
        //滚动的方式
        //BouncingScrollPhysics 阻尼效果
        //ClampingScrollPhysics 水波纹效果
        physics:ClampingScrollPhysics(),
        //是否具有回弹效果，默认为 true
        pageSnapping: true,
        onPageChanged: (index) {
          //监听事件
          print('index=====$index');
        },
        //具体子控件的布局
        children: <Widget>[
          Container(
            color: Colors.tealAccent,
            child: Center(
              child: Text(
                '第1页',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            color: Colors.greenAccent,
            child: Center(
              child: Text(
                '第2页',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            color: Colors.deepOrange,
            child: Center(
              child: Text(
                '第3页',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
