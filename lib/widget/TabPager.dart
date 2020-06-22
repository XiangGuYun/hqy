import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:flutter/material.dart';
import '../my_lib/extension/BaseExtension.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController _controller;

  ///当组件销毁时调用
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
    //监听Tab切换事件
    _controller.addListener(() {
      print(_controller.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Container(
            height: 40.0,
            child: TabBar(
              indicator: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFB3926F), Color(0xFFDAC4A8)]),
                borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              controller: _controller,
              tabs: <Widget>[
                Text(
                  "Tab1",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Tab1",
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Tab1",
                  style: TextStyle(color: Colors.black),
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
            child: Text("Tab1"),
          ),
          Center(
            child: Text("Tab2"),
          ),
          Center(
            child: Text("Tab3"),
          ),
        ],
      ),
    );
  }
}
