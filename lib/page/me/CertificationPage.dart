import 'package:flutter/material.dart';
import 'package:wobei/bean/Pair.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/eventbus/EventBus.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';
import 'package:wobei/widget/EditText.dart';
import '../../my_lib/extension/BaseExtension.dart';

///********************************************************************************************
///
/// 实名认证
/// 从这个界面开始，只要是涉及到状态管理、需要用户操作的组件一律抽离出来
///
///********************************************************************************************
class CertificationPage extends StatefulWidget {
  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> with BaseUtils {

  ///登录按钮颜色
  var buttonColor = Config.BTN_ENABLE_FALSE;

  /// 真实姓名
  var valueRealName = '';

  /// 身份证号码
  var valueIdCardNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: getStatusBarHeight(),
          ),
          Container(
            child: Image.asset(
              Config.CLOSE,
              width: 24,
              height: 24,
            ).setInkWell(onTap: (){
              Navigator.of(context).pop();
            }),
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            height: 44,
          ),
          Container(
            child: Text(
              '实名认证',
              style: TextStyle(
                  color: Config.BLACK_303133,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            margin: EdgeInsets.only(left: 40, top: 40, bottom: 20),
          ),
          inputRealName(),
          Divider(height: 1, color: Config.DIVIDER_COLOR, indent: 40, endIndent: 40,),
          inputIdCardNumber(),
          Divider(height: 1, color: Config.DIVIDER_COLOR, indent: 40, endIndent: 40,),
          SizedBox(height: 40,),
          buttonNext(),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 输入真实姓名
  ///---------------------------------------------------------------------------
  inputRealName() {
    return Container(
      width: context.getSrnW(),
      height: 60,
      margin: EdgeInsets.only(left: 40, right: 40),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '真实姓名',
            style: TextStyle(
                fontSize: 16,
                color: Config.BLACK_303133,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child:  EditText(
              200,
              height: 60,
              hint: '请填写真实姓名',
              textSize: 16,
              textColor: Config.BLACK_303133,
              padding: EdgeInsets.only(top: 7),
              onChanged: (value){
                valueRealName = value;
                setState(() {
                  if(valueRealName.length>2 && valueIdCardNumber.length == 18){
                    buttonColor = Config.BLACK_303133;
                  } else {
                    buttonColor = Config.BTN_ENABLE_FALSE;
                  }
                });
              },
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 输入身份证号
  ///---------------------------------------------------------------------------
  inputIdCardNumber() {
    return Container(
      width: context.getSrnW(),
      height: 60,
      margin: EdgeInsets.only(left: 40, right: 40),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '身份证号',
            style: TextStyle(
                fontSize: 16,
                color: Config.BLACK_303133,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child:  EditText(
              200,
              height: 60,
              hint: '请填写身份证号码',
              textSize: 16,
              textColor: Config.BLACK_303133,
              padding: EdgeInsets.only(top: 7),
              maxLength: 18,
              onChanged: (value){
                valueIdCardNumber = value;
                setState(() {
                  if(valueRealName.length>2 && valueIdCardNumber.length == 18){
                    buttonColor = Config.BLACK_303133;
                  } else {
                    buttonColor = Config.BTN_ENABLE_FALSE;
                  }
                });
              },
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 下一步按钮
  ///---------------------------------------------------------------------------
  buttonNext() {
    return Container(
      child: Text(
        '下一步',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ).setGestureDetector(
        onTap: (){
          if(buttonColor == Config.BLACK_303133){
            Req.certification(valueRealName, valueIdCardNumber, (msg){
              ToastUtils.show('实名认证成功');
              bus.emit('PersonalInfoPage', Pair(first: 'certificated', second: true));
              Navigator.of(context).pop();
            }, (msg){
              ToastUtils.show(msg);
            });
          }
        },
        onTapDown: (details) {
          setState(() {
            buttonColor = Config.BTN_TAP_DOWN;
          });
        },
        onTapUp: (details) {
          setState(() {
          buttonColor = (valueRealName.length < 2 || valueIdCardNumber.length < 18)
              ? Config.BTN_ENABLE_FALSE
              : Config.BLACK_303133;
        });
      },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: buttonColor,
      ),
      width: context.getSrnW() - 80,
      height: 50,
      margin: EdgeInsets.only(left: 40),
      alignment: Alignment.center,
    );
  }
}
