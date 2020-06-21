import 'package:flutter/material.dart';

final String avatar =
    'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1764219719,2359539133&fm=26&gp=0.jpg';

///基础版本
//下面我们演示一下最基础的动画实现方式：
class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(avatar,
          width: animation.value, height: animation.value),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

//上面的例子中并没有指定Curve，所以放大的过程是线性的（匀速），下面我们指定一个Curve，
//来实现一个类似于弹簧效果的动画过程，我们只需要将initState中的代码改为下面这样即可：
class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState1 createState() => _ScaleAnimationRouteState1();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState1 extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      //这段代码必须加上，否则动画不会执行
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network(avatar,
          width: animation.value, height: animation.value),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///使用AnimatedWidget简化
//细心的读者可能已经发现上面示例中通过addListener()和setState() 来更新UI这一步其实是通用的，
//如果每个动画中都加这么一句是比较繁琐的。AnimatedWidget类封装了调用setState()的细节，
//并允许我们将widget分离出来，重构后的代码如下：
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.network(
        avatar,
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState2 createState() => _ScaleAnimationRouteState2();
}

class _ScaleAnimationRouteState2 extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
//    return AnimatedImage(
//      animation: animation,
//    );
    return AnimatedBuilder(
      animation: animation,
      child: Image.network(avatar),
      builder: (BuildContext ctx, Widget child) {
        return Center(
          child: Container(
            height: animation.value,
            width: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

///使用AnimatedBuilder进一步简化
//1.不需要写addListener和setState来更新动画值
//2.不需要为每种动画组件都创建一个AnimatedWidget
//3.通过AnimatedBuilder可以封装常见的过渡效果来复用动画。
class ScaleAnimationRoute3 extends StatefulWidget {
  @override
  _ScaleAnimationRouteState3 createState() => _ScaleAnimationRouteState3();
}

class _ScaleAnimationRouteState3 extends State<ScaleAnimationRoute3>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation,
        child: Image.network(avatar),
        builder: (BuildContext ctx, Widget child) {
          return Center(
            child: Container(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          );
        },
      ),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

//下面我们通过封装一个GrowTransition来说明，它可以对子widget实现放大动画：
//class GrowTransition extends StatelessWidget {
//  GrowTransition({this.child, this.animation});
//
//  final Widget child;
//  final Animation<double> animation;
//
//  Widget build(BuildContext context) {
//    return Center(
//      child: AnimatedBuilder(
//          animation: animation,
//          builder: (BuildContext context, Widget child) {
//            return Container(
//                height: animation.value, width: animation.value, child: child);
//          },
//          child: child),
//    );
//  }
//}

//class ScaleAnimationRoute4 extends StatefulWidget {
//  @override
//  _ScaleAnimationRouteState4 createState() => _ScaleAnimationRouteState4();
//}
//
//class _ScaleAnimationRouteState4 extends State<ScaleAnimationRoute4>
//    with SingleTickerProviderStateMixin {
//  Animation<double> animation;
//  AnimationController controller;
//
//  initState() {
//    super.initState();
//    controller =
//        AnimationController(duration: const Duration(seconds: 3), vsync: this);
//    //图片宽高从0变到300
//    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
//    //启动动画
//    controller.forward();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: GrowTransition(
//      child: Image.network(avatar),
//      animation: animation,
//    ));
//  }
//
//  dispose() {
//    //路由销毁时需要释放动画资源
//    controller.dispose();
//    super.dispose();
//  }
//}
//Flutter中正是通过这种方式封装了很多动画，如：FadeTransition、ScaleTransition、SizeTransition等，
//很多时候都可以复用这些预置的过渡类。

///动画状态监听
//上面说过，我们可以通过Animation的addStatusListener()方法来添加动画状态改变监听器。
//Flutter中，有四种动画状态，在AnimationStatus枚举类中定义，下面我们逐个说明：
//
//枚举值	    含义
//dismissed	动画在起始点停止
//forward	  动画正在正向执行
//reverse	  动画正在反向执行
//completed	动画在终点停止

//示例
//我们将上面图片放大的示例改为先放大再缩小再放大……这样的循环动画。
//要实现这种效果，我们只需要监听动画状态的改变即可，
//即：在动画正向执行结束时反转动画，在动画反向执行结束时再正向执行动画。代码如下：
/*
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }
 */