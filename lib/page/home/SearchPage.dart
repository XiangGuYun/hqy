import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/ToastUtils.dart';
import 'package:wobei/widget/EditText.dart';
import 'package:wobei/widget/MyWidget.dart';

import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
///
/// 描述：搜索页
/// 作者：YeXudong
/// 创建时间：2020/7
///
///*****************************************************************************
class SearchPage extends StatefulWidget {

  final List<String> arguments;

  SearchPage({this.arguments});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with BaseUtils {
  /// 搜索推荐词列表
  List<String> wordList;

  @override
  void initState() {
    super.initState();
    wordList = widget.arguments;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          Container(
            width: double.infinity,
            height: 44,
            padding: EdgeInsets.only(left: 20, right: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MyWidget.getBackArrow().setGestureDetector(onTap: () {
                  Navigator.of(context).pop();
                }).setSizedBox(width: 34),
                Container(
                  width: 0,
                  height: 36,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                      color: '#fff5f7fa'.color(),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Image.asset(
                          Config.SEARCH,
                          width: 18,
                          height: 18,
                          fit: BoxFit.contain,
                        ),
                        top: 0,
                        bottom: 0,
                      ),
                      Positioned(
                        bottom: 0,
                        child: EditText(
                          215,
                          hint: '爱奇艺VIP月卡',
                          height: 24,
                          maxLength: 10,

                          margin: EdgeInsets.only(left: 38, top: 5),
                          padding: EdgeInsets.only(top: 5),
                        ),
                      )
                    ],
                  ).setSizedBox(height: 36),
                ).setExpanded(1),
                Text(
                  '搜索',
                  style: TextStyle(fontSize: 14, color: Color(0xff303133)),
                ).setCenter().setSizedBox(width: 68)
              ],
            ),
          ),
          Text(
            '发现更多',
            style: TextStyle(
                fontSize: 16,
                color: Config.BLACK_303133,
                fontWeight: FontWeight.w500),
          ).setMargin1(left: 20, top: 25, bottom: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: wordList.map((s){
              return Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f7fa),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                child: Text(s, style: TextStyle(fontSize: 14, color: Color(0xff909399)),).setGestureDetector(
                    onTap: (){
                      ToastUtils.show(s);
                    }
                ),
              );
            }).toList(),
          ).setMargin1(left: 20)
        ],
      ),
    );
  }
}
