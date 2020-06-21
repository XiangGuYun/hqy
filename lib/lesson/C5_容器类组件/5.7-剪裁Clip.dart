import 'package:flutter/material.dart';

///Flutter中提供了一些剪裁函数，用于对组件进行剪裁。
//
//剪裁Widget	作用
//ClipOval	子组件为正方形时剪裁为内贴圆形，为矩形时，剪裁为内贴椭圆
//ClipRRect	将子组件剪裁为圆角矩形
//ClipRect	剪裁子组件到实际占用的矩形大小（溢出部分剪裁）

class ClipTestRoute extends StatelessWidget {

  var imgUrl = 'https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1950846641,3729028697&fm=111&gp=0.jpg';

  @override
  Widget build(BuildContext context) {
    // 头像
    Widget avatar = Image.network(imgUrl, width: 60.0);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            avatar, //不剪裁
            ClipOval(child: avatar), //剪裁为圆形
            ClipRRect( //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                Text("你好世界", style: TextStyle(color: Colors.green),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(//将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5,//宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                Text("你好世界",style: TextStyle(color: Colors.green))
              ],
            ),
          ],
        ),
      ),
    );
  }
}