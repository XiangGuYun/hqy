import 'package:flutter/material.dart';
import 'package:wobei/my_lib/base/BaseState.dart';

///=============================================================================
///顶部标题栏
///=============================================================================
class TitleBar extends StatelessWidget with BaseUtils {
  ///标题
  final String title;

  ///副标题
  final String subTitle;

  ///是否需要下方的分割线
  final bool needDivider;

  ///是否需要添加左右外边距
  final bool needMargin;

  ///副标题点击事件
  final Function subTitleClick;

  TitleBar(
      {Key key,
      @required this.title,
      this.subTitle = '',
      this.needDivider = true,
      this.needMargin = true,
      this.subTitleClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: getStatusBarHeight()),
      width: double.infinity,
      height: 44,
      child: Stack(
        children: <Widget>[
          Padding(
            child: Align(
              child: Image.asset(
                'assets/images/back_black.png',
                width: 22,
                height: 22,
                fit: BoxFit.cover,
              ),
              alignment: Alignment(-1, 0),
            ),
            padding: EdgeInsets.only(left: needMargin ? 20 : 0),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff393649),
                  fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            child: Divider(
              height: 1,
              color: needDivider ? Color(0xffeeeeee) : Colors.transparent,
            ),
            alignment: Alignment.bottomLeft,
          ),
          Padding(
            child: Align(
              child: GestureDetector(
                child: Text(
                  subTitle,
                  style: TextStyle(fontSize: 14, color: Color(0xff393649)),
                ),
                onTap: subTitleClick,
              ),
              alignment: Alignment(1, 0),
            ),
            padding: EdgeInsets.only(right: 20),
          )
        ],
      ),
    );
  }
}
