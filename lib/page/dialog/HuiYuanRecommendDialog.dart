import 'package:flutter/material.dart';
import 'package:wobei/page/dialog/BaseDialog.dart';

///*****************************************************************************
///
/// 会员享优惠对话框
///
///*****************************************************************************
class HuiYuanXiangYouHuiDialog extends BaseDialog{

  /// 优惠价格
  final String price;
  /// "原价购买"点击事件
  final Function leftBtnClick;
  /// "购买会员"点击事件
  final Function rightBtnClick;

  HuiYuanXiangYouHuiDialog(this.price, {this.leftBtnClick, this.rightBtnClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 295,
          height: 214,
          decoration: BoxDecoration( //setBackgroundColor强化版
            //设置边框颜色和宽度以及样式
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text('会员享优惠', style: TextStyle(fontSize: 22, color: Color(0xff393649)),),
                padding: EdgeInsets.only(left: 30, top: 30),
              ),
              Padding(
                child: Text('会员购买可优惠$price元，现在就成为会员享受更多优惠！', style: TextStyle(fontSize: 14, color: Color(0xff6f6c7a)),),
                padding: EdgeInsets.only(left: 30, top: 12, right: 30, bottom: 36),
              ),
              Divider(height: 1.0,indent: 0.0,color: Color(0xFFEDECEE),),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          child: Text('原价购买', style: TextStyle(fontSize: 16, color: Color(0xffa5a3ac)),),
                          onTap: leftBtnClick,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: Color(0xFFEDECEE),
                      margin: EdgeInsets.only(top: 22.5, bottom: 22.5),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: InkWell(
                          onTap: rightBtnClick,
                          child: Text('购买会员', style: TextStyle(fontSize: 16, color: Color(0xff393649)),),
                        ),
                      ),
                    )
                  ],
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}