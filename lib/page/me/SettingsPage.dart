import 'package:flutter/material.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/eventbus/EventBus.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/page/dialog/QuitLoginDialog.dart';
import 'package:wobei/widget/BlackButton.dart';
import 'package:wobei/widget/TitleBar.dart';

///********************************************************************************************
///
/// 设置页面
///
///********************************************************************************************
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with BaseUtils {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          TitleBar(
            title: '设置',
          ),
          getItemView('关于禾贝', 'V1.5.0', (){
            Navigator.of(context).pushNamed(AppRoute.ABOUT);
          }),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          getItemView('用户协议', '', (){
            Navigator.of(context).pushNamed(AppRoute.WEB_PAGE,
                arguments: "https://h5.hbei.vip/app/user_agreement");
          }),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          getItemView('隐私政策', '', (){
            Navigator.of(context).pushNamed(AppRoute.WEB_PAGE,
                arguments: "https://h5.hbei.vip/app/PrivacyPolicy");
          }),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 1,
            ),
            flex: 1,
          ),
          BlackButton(text: '退出当前账号', onClickListener: _quitLogin),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 退出登录
  ///---------------------------------------------------------------------------
  void _quitLogin(){
    QuitLoginDialog(rightBtnClick: (){
//      bp { m w CLEAR_ME_LIST }
//      bp { m w CLEAR_BADGE_NUMBER }
      // 清空本地数据
      Global.prefs.setString('token', '');
      // 执行退出操作
      bus.emit('Scaffold', 'unlogin');
      // 退出对话框
      Navigator.of(context).pop();
      // 退出设置页面
      Navigator.of(context).pop();
    },).show(context);
  }

  getItemView(String left, String right, Function callback) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 60,
        color: Colors.white,
        margin: EdgeInsets.only(left: 20, right: 20),
        child:Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                child: Text(
                  left,
                  style: TextStyle(fontSize: 16, color: Config.BLACK_303133),
                ),
                alignment: Alignment(-1, 0),
              ),
            ),
            Positioned(
              child: Container(
                child: Image.asset(Config.DETAIL_LIGHT),
                alignment: Alignment(-1, 0),
                height: 60,
              ),
              right: 0,
            )
          ],
        ),
      ),
      onTap: callback,
    );
  }
}
