import 'package:flutter/material.dart';
import 'package:wobei/my_lib/utils/System.dart';

///Material组件库中的按钮
///RaisedButton
//RaisedButton 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
class ButtonTest1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("normal"),
          onPressed: () {
            //点击事件
          },
        ),
      ),
    );
  }
}

///FlatButton
//FlatButton即扁平按钮，默认背景透明并不带阴影。按下后，会有背景色
class ButtonTest2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("normal"),
          onPressed: () {},
        ),
      ),
    );
  }
}

///OutlineButton
//OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
class ButtonTest3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlineButton(
          child: Text("normal"),
          onPressed: () {},
        ),
      ),
    );
  }
}

///IconButton
//IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
class ButtonTest4Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () {},
        ),
      ),
    );
  }
}

///带图标的按钮
//RaisedButton、FlatButton、OutlineButton都有一个icon构造函数，通过它可以轻松创建带图标的按钮
class ButtonTest5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.send),
              label: Text("发送"),
              onPressed: (){},
            ),
            OutlineButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: (){},
            ),
            FlatButton.icon(
              icon: Icon(Icons.info),
              label: Text("详情"),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}

///自定义按钮外观
//按钮外观可以通过其属性来定义，不同按钮属性大同小异，我们以FlatButton为例，
//介绍一下常见的按钮属性，详细的信息可以查看API文档。
/*
const FlatButton({
  ...
  @required this.onPressed, //按钮点击回调
  this.textColor, //按钮文字颜色
  this.disabledTextColor, //按钮禁用时的文字颜色
  this.color, //按钮背景颜色
  this.disabledColor,//按钮禁用时的背景颜色
  this.highlightColor, //按钮按下时的背景颜色
  this.splashColor, //点击时，水波动画中水波的颜色
  this.colorBrightness,//按钮主题，默认是浅色主题
  this.padding, //按钮的填充
  this.shape, //外形
  @required this.child, //按钮的内容
})
 */
class ButtonTest6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text("Submit"),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () {},
        ),
      ),
    );
  }
}