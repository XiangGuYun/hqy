import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wobei/page/dialog/BaseDialog.dart';

///********************************************************************************************
///
/// 退出登录对话框
///
///********************************************************************************************
class QuitLoginDialog extends BaseDialog {
  final Function rightBtnClick;

  QuitLoginDialog({this.rightBtnClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 295,
          height: 214,
          decoration: BoxDecoration(
            //setBackgroundColor强化版
            //设置边框颜色和宽度以及样式
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  '确认退出',
                  style: TextStyle(fontSize: 22, color: Color(0xff393649)),
                ),
                padding: EdgeInsets.only(left: 30, top: 30),
              ),
              Padding(
                child: Text(
                  '确认退出当前账号？',
                  style: TextStyle(fontSize: 14, color: Color(0xff6f6c7a)),
                ),
                padding:
                    EdgeInsets.only(left: 30, top: 12, right: 30, bottom: 36),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                height: 1.0,
                indent: 0.0,
                color: Color(0xFFEDECEE),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '取消',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xffa5a3ac)),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
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
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(12))
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '确定退出',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff393649)),
                            ),
                          ),
                          onTap: rightBtnClick,
                        ),
                      )
                    ],
                  ),
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
