import 'package:flutter/material.dart';

//在Flutter中页面UI通常都是由一些低阶别的组件组合而成，当我们需要封装一些通用组件时，
//应该首先考虑是否可以通过组合其它组件来实现，如果可以，则应优先使用组合，
//因为直接通过现有组件拼装会非常简单、灵活、高效。

//示例：自定义渐变按钮
//Flutter Material组件库中的按钮默认不支持渐变背景，为了实现渐变背景按钮，
//我们自定义一个GradientButton组件，它需要支持一下功能：
//
//背景支持渐变色
//手指按下时有涟漪效果
//可以支持圆角
class GradientButton extends StatelessWidget {
  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    @required this.child,
  });

  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  //点击回调
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Test1ComboPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GradientButton(
          child: Text('你好呀', style: TextStyle(fontSize: 20),),
          width: 120.0,
          height: 60.0,
          onPressed: () {},
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
