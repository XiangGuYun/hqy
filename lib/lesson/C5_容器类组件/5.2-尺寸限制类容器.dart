import 'package:flutter/material.dart';

///尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器

/// ConstrainedBox
/// 用于对子组件添加额外的约束。例如，如果你想让子组件的最小高度是80像素，
/// 你可以使用const BoxConstraints(minHeight: 80.0)作为子组件的约束。
/// 我们先定义一个redBox，它是一个背景颜色为红色的盒子，不指定它的宽度和高度：
Widget redBox=DecoratedBox(
  decoration: BoxDecoration(color: Colors.red),
);
///我们实现一个最小高度为50，宽度尽可能大的红色容器。
class RedConstrainedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: double.infinity, //宽度尽可能大
          minHeight: 50.0 //最小高度为50像素
      ),
      child: Container(
          height: 5.0,//这里☞高度仅为5
          child: redBox
      ),
    );
  }
}
///运行效果见：https://pcdn.flutterchina.club/imgs/5-2.png
///可以看到，我们虽然将Container的高度设置为5像素，但是最终却是50像素，
///这正是ConstrainedBox的最小高度限制生效了。
///如果将Container的高度设置为80像素，那么最终红色区域的高度也会是80像素，
///因为在此示例中，ConstrainedBox只限制了最小高度，并未限制最大高度。

///SizedBox
///用于给子元素指定固定的宽高
/*
SizedBox(
  width: 80.0,
  height: 80.0,
  child: redBox
)
 */
///实际上SizedBox只是ConstrainedBox的一个定制，上面代码等价于：
/*
ConstrainedBox(
  constraints: BoxConstraints.tightFor(width: 80.0,height: 80.0),
  child: redBox,
)
 */
///而BoxConstraints.tightFor(width: 80.0,height: 80.0)等价于：
/*
BoxConstraints(minHeight: 80.0,maxHeight: 80.0,minWidth: 80.0,maxWidth: 80.0)
 */
///而实际上ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的，
///我们可以看到ConstrainedBox和SizedBox的createRenderObject()方法都返回的是一个RenderConstrainedBox对象
/*
override
RenderConstrainedBox createRenderObject(BuildContext context) {
  return new RenderConstrainedBox(
    additionalConstraints: ...,
  );
}
 */

///还有一些其他的尺寸限制类容器，比如
///AspectRatio：它可以指定子组件的长宽比
///LimitedBox：用于指定最大宽高
///FractionallySizedBox：可以根据父容器宽高的百分比来设置子组件宽高
