import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/frame_anim/FrameAnimPage.dart';
import 'package:wobei/lesson/plugin_dev/PluginDevPage.dart';
import 'package:wobei/lesson/provider/ProviderTest.dart';
import 'package:wobei/lesson/pull_to_refresh/PullToRefreshPage.dart';
import 'package:wobei/page/me/MePage.dart';
import 'package:wobei/page/order/ShippingAddressPage.dart';
import 'package:wobei/widget/TabPager.dart';
import 'package:wobei/widget/TitleBar.dart';
import 'package:wobei/widget/VipPriceText.dart';
import 'package:wobei/widget/myorder/CompletedItem.dart';
import 'package:wobei/widget/myorder/FailuredItem.dart';
import 'package:wobei/widget/myorder/ForDeliverItem.dart';
import 'package:wobei/widget/myorder/ForPaymentItem.dart';

///********************************************************************************************
///
/// 用于测试的页面
///
///********************************************************************************************
class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 12,
              ),
              Text(
                'result.name',
                style: TextStyle(fontSize: 14, color: Config.BLACK_303133),
              ),
              Row(
                children: <Widget>[
                  VipPriceText(
                    price: '12.00',
                  ),
                  Text(
                    '¥ 14.50',
                    style: TextStyle(
                      fontSize: 14, color: Config.GREY_C0C4CC,
                      decoration: TextDecoration.lineThrough, //删除线
                      decorationColor: Config.GREY_C0C4CC,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
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
