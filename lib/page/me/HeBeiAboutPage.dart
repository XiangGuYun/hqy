import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/widget/TitleBar.dart';

class HeBeiAboutPage extends StatefulWidget {
  @override
  _HeBeiAboutPageState createState() => _HeBeiAboutPageState();
}

class _HeBeiAboutPageState extends State<HeBeiAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          TitleBar(
            title: '关于禾贝',
          ),
          SizedBox(
            height: 80,
          ),
          Image.asset(
            Config.ICON,
            width: 70,
            height: 70,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '高价值的会员权益平台',
            style: TextStyle(color: Config.BLACK_303133, fontSize: 18),
          ),
          SizedBox(height: 10,),
          Text(
            'V 1.5.0',
            style: TextStyle(color: Config.GREY_909399, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
