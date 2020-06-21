import 'package:flutter/material.dart';
import 'package:wobei/page/order/ShippingAddressPage.dart';
import 'package:wobei/widget/myorder/CompletedItem.dart';
import 'package:wobei/widget/myorder/FailuredItem.dart';
import 'package:wobei/widget/myorder/ForDeliverItem.dart';
import 'package:wobei/widget/myorder/ForPaymentItem.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xffeeeeee),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: ShippingAddressPage(),
      ),
    );
  }
}
