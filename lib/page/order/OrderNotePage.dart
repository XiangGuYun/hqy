import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/widget/TitleBar.dart';

///订单备注
class OrderNotePage extends StatefulWidget {
  @override
  _OrderNotePageState createState() => _OrderNotePageState();
}

class _OrderNotePageState extends State<OrderNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          TitleBar(
            title: '订单备注',
            needDivider: false,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(0xfff5f5f5),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            width: double.infinity,
            height: 90,
            padding: EdgeInsets.only(left: 16),
            child: TextField(
              textAlign: TextAlign.start,
              maxLines: 10,
                decoration: InputDecoration(
                  //设置提示文字
                    hintText: "请输入备注",
                    hintStyle:
                    TextStyle(fontSize: 16, color: Color(0xFFC0C4CC)),
                    //设置边框
                    border: InputBorder.none //去除
                )
            ),
          )
        ],
      ),
    );
  }
}
