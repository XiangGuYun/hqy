import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
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
/// 编辑昵称
///
///********************************************************************************************
class NicknamePage extends StatefulWidget {
  /// 昵称
  final String nickname;

  NicknamePage({this.nickname});

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> with BaseUtils {
  /// 昵称
  var nickname = '';

  @override
  void initState() {
    super.initState();
    nickname = widget.nickname;

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: getStatusBarHeight(),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                child: Center(
                  child: Text(
                    '昵称',
                    style: TextStyle(color: Config.BLACK_303133, fontSize: 18),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                child: Container(
                  child: Text(
                    '取消',
                    style: TextStyle(color: Config.GREY_909399, fontSize: 14),
                  ),
                  alignment: Alignment(-1, 0),
                  height: 44,
                ).setInkWell(onTap: () {
                  Navigator.of(context).pop();
                }),
              ),
              Positioned(
                right: 20,
                child: Container(
                  child: Text(
                    '保存',
                    style: TextStyle(color: Config.BLACK_303133, fontSize: 14),
                  ),
                  alignment: Alignment(1, 0),
                  height: 44,
                ).setGestureDetector(onTap: saveNickname),
              )
            ],
          ).setSizedBox(height: 44),
          Divider(
            height: 1,
            color: Config.DIVIDER_COLOR,
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: <Widget>[
              Positioned(
                child: EditText(
                  200,
                  height: 60,
                  controller: TextEditingController.fromValue(TextEditingValue(
                      // 设置内容
                      text: nickname,
                      // 保持光标在最后
                      selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: nickname.length,
                      )))),
                  maxLength: 10,
                  padding: EdgeInsets.only(top: 7),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  onChanged: (value) {
                    nickname = value;
                  },
                ),
              ),
              Positioned(
                right: 20,
                top: 22,
                child: Image.asset(
                  Config.CLEAR,
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ).setGestureDetector(onTap: clearNickname),
              )
            ],
          ).setSizedBox(width: context.getSrnW()),
          Divider(
            height: 1,
            color: Config.DIVIDER_COLOR,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '1~20字符，特殊字符除外',
            style: TextStyle(fontSize: 14, color: Config.GREY_909399),
          ).setMargin1(left: 20)
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 保存昵称
  ///---------------------------------------------------------------------------
  void saveNickname() {
    var params = Map<String, String>();
    params['nickname'] = nickname;
    Req.modifyMeInfo(params, () {
      bus.emit('PersonalInfoPage', Pair(first: 'nickname', second: nickname));
      bus.emit('MePage', Pair(first: 'nickname', second: nickname));
      Navigator.of(context).pop();
    });
  }

  ///---------------------------------------------------------------------------
  /// 清空填写的昵称
  ///---------------------------------------------------------------------------
  void clearNickname() {
    setState(() {
      nickname = '';
    });
  }
}
