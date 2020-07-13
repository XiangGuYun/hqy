import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/page/dialog/BaseDialog.dart';
import 'package:wobei/widget/EditText.dart';
import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
///
/// 图片验证码对话框
///
///*****************************************************************************
class TuPianYanZhengMaDialog extends BaseDialog {
  /// 验证码二进制图片
  final Uint8List bytes;

  /// 验证码
  var code = '';

  /// 手机号码
  final String phone;

  final BuildContext ctx;

  TuPianYanZhengMaDialog({this.ctx, this.phone = '', this.bytes});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 295,
          height: 255,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  '请填写图片验证码',
                  style: TextStyle(fontSize: 22, color: Color(0xff393649)),
                ),
                padding: EdgeInsets.only(left: 30, top: 30),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: EditText(
                      40,
                      hint: '请输入图片验证码',
                      textSize: 16,
                      maxLength: 4,
                      inputType: TextInputType.number,
                      onChanged: (value) {
                        code = value;
                        print('===========${code.toString().length}');
                      },
                    ),
                    flex: 1,
                  ),
                  Image.memory(
                    bytes,
                    width: 90,
                    height: 40,
                    fit: BoxFit.fill,
                  ).setClipRRect(5),
                  SizedBox(
                    width: 30,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Divider(
                  color: Config.DIVIDER_COLOR,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 1,
                ),
                flex: 1,
              ),
              Divider(
                color: Config.DIVIDER_COLOR,
                height: 1,
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        '取消',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xffa5a3ac)),
                      ),
                      onTap: () {
                        Navigator.of(ctx).pop();
                      },
                    ).setCenter().setExpanded(1),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: Color(0xFFEDECEE),
                      margin: EdgeInsets.only(top: 22.5, bottom: 22.5),
                    ),
                    InkWell(
                      onTap: () {
                        if (code.length < 4) {
                          '请输入正确的验证码'.toast();
                          return;
                        }
                        Req.getVCode(phone, (token) {
                          Navigator.of(ctx).pop();
                          '验证码已发送'.toast();
                        }, verifyPictureCode: code);
                      },
                      child: Text(
                        '确定',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff393649)),
                      ),
                    ).setCenter().setExpanded(1)
                  ],
                ),
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
