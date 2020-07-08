import 'package:flutter/material.dart';
import 'package:wobei/lesson/frame_anim/FrameAnimPage.dart';
import 'package:wobei/lesson/plugin_dev/PluginDevPage.dart';
import 'package:wobei/lesson/provider/ProviderTest.dart';
import 'package:wobei/lesson/pull_to_refresh/PullToRefreshPage.dart';
import 'package:wobei/page/me/MePage.dart';
import 'package:wobei/page/order/ShippingAddressPage.dart';
import 'package:wobei/widget/TabPager.dart';
import 'package:wobei/widget/TitleBar.dart';
import 'package:wobei/widget/myorder/CompletedItem.dart';
import 'package:wobei/widget/myorder/FailuredItem.dart';
import 'package:wobei/widget/myorder/ForDeliverItem.dart';
import 'package:wobei/widget/myorder/ForPaymentItem.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage());
  }
}

//Scaffold(
//appBar: PreferredSize(
//child: AppBar(
//flexibleSpace: TitleBar(
//title: "会员商城",
//subTitle: "我的订单",
//subTitleClick: (){
//print('----------------------------------');
//},
//),
//elevation: 0,
//backgroundColor: Colors.white,
//),
//preferredSize: Size.fromHeight(44),
//),
//backgroundColor: Colors.white,
//resizeToAvoidBottomPadding: false,
//body: MyApp(),
//),
//)
