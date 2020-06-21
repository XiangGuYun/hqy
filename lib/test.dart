import 'package:flutter/material.dart';
import 'package:wobei/lesson/eventbus/PageA.dart';
import 'package:wobei/page/ScaffoldPage.dart';
import 'package:wobei/page/home/HomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/order/OrderNotePage.dart';
import 'package:wobei/test/PageViewTestApp.dart';
import 'package:wobei/widget/PayPasswordTextField.dart';
import 'package:wobei/widget/ProductDetailPage.dart';
import 'package:wobei/widget/ProductItem.dart';

import 'lesson/C10_自定义组件/组合现有组件.dart';
import 'lesson/C3_基础组件/3.1_Widget简介.dart';
import 'lesson/C3_基础组件/3.3_文本及样式.dart';
import 'lesson/C3_基础组件/3.4_按钮.dart';
import 'lesson/C3_基础组件/3.5_图片及ICON.dart';
import 'lesson/C3_基础组件/3.6_单选开关和复选框.dart';
import 'lesson/C3_基础组件/3.8_进度指示器.dart';
import 'lesson/C6_可滚动组件/6.2_SingleChildScrollView.dart';
import 'lesson/C6_可滚动组件/6.3_ListView.dart';
import 'lesson/C6_可滚动组件/6.4-GridView.dart';
import 'lesson/C6_可滚动组件/6.5_CustomScrollView.dart';
import 'lesson/C6_可滚动组件/6.6_滚动监听及控制.dart';
import 'lesson/C7_功能型组件/7.1_导航返回拦截WillPopScope.dart';
import 'lesson/C7_功能型组件/7.2_数据共享InheritedWidget.dart';
import 'lesson/C7_功能型组件/7.3_跨组件状态共享Provider.dart';
import 'lesson/C7_功能型组件/7.4_颜色和主题.dart';
import 'lesson/C7_功能型组件/7.5_异步UI更新FutureBuilder_StreamBuilder.dart';
import 'lesson/C5_容器类组件/5.4-变换Transform.dart';
import 'lesson/C5_容器类组件/5.5-Container.dart';
import 'lesson/C5_容器类组件/5.6-5.6 Scaffold-TabBar-底部导航.dart';
import 'lesson/C5_容器类组件/5.7-剪裁Clip.dart';
import 'lesson/C7_功能型组件/dialog/DialogPage.dart';
import 'lesson/C7_功能型组件/dialog/SimpleDialogPage.dart';
import 'lesson/C8_事件处理与通知/8.1_原始指针事件处理.dart';
import 'lesson/C9_动画/9.2_动画基本结构及状态监听.dart';
import 'lesson/C9_动画/9.3_自定义路由切换动画.dart';
import 'lesson/C9_动画/9.4_Hero动画.dart';
import 'lesson/C9_动画/9.5_交织动画.dart';
import 'lesson/C9_动画/9.6_通用动画切换组件.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xffeeeeee),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: PayPasswordTextField(),
        ),
      ),
    );
  }
}
