import 'package:flutter/material.dart';

//AnimatedSwitcher 可以同时对其新、旧子元素添加显示、隐藏动画。
//也就是说在AnimatedSwitcher的子元素发生变化时，会对其旧元素和新元素同时进行动画，
//我们先看看AnimatedSwitcher 的定义：
/*
const AnimatedSwitcher({
  Key key,
  this.child,
  @required this.duration, // 新child显示动画时长
  this.reverseDuration,// 旧child隐藏的动画时长
  this.switchInCurve = Curves.linear, // 新child显示的动画曲线
  this.switchOutCurve = Curves.linear,// 旧child隐藏的动画曲线
  // 动画构建器
  //默认情况下，AnimatedSwitcher会对新旧child执行“渐隐”和“渐显”动画。
  this.transitionBuilder = AnimatedSwitcher.defaultTransitionBuilder,
  this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder, //布局构建器
})
 */

//下面我们看一个列子：实现一个计数器，然后在每一次自增的过程中，旧数字执行缩小动画隐藏，
//新数字执行放大动画显示，代码如下：
class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                //执行缩放动画
                return ScaleTransition(child: child, scale: animation);
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                //key可以理解为一个widget的唯一标签
                key: ValueKey<int>(_count),
                style: TextStyle(
                    fontSize: 100), //Theme.of(context).textTheme.headline
              ),
            ),
            RaisedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

///AnimatedSwitcher高级用法
class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    //动画反向执行时，调整x偏移，实现“从左边滑出隐藏”
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class AnimatedSwitcherCounterRoute1 extends StatefulWidget {
  const AnimatedSwitcherCounterRoute1({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState1 createState() =>
      _AnimatedSwitcherCounterRouteState1();
}

class _AnimatedSwitcherCounterRouteState1
    extends State<AnimatedSwitcherCounterRoute1> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween =
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return MySlideTransition(
                  child: child,
                  position: tween.animate(animation),
                );
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                //key可以理解为一个widget的唯一标签
                key: ValueKey<int>(_count),
                style: TextStyle(
                    fontSize: 100), //Theme.of(context).textTheme.headline
              ),
            ),
            RaisedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//本节将封装一个通用的SlideTransitionX 来实现这种“出入滑动动画”
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }


  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
//现在如果我们想实现各种“滑动出入动画”便非常容易，只需给direction传递不同的方向值即可，比如要实现“上入下出”，则：
class AnimatedSwitcherCounterRoute2 extends StatefulWidget {
  const AnimatedSwitcherCounterRoute2({Key key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState2 createState() =>
      _AnimatedSwitcherCounterRouteState2();
}

class _AnimatedSwitcherCounterRouteState2
    extends State<AnimatedSwitcherCounterRoute2> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
                return SlideTransitionX(
                  child: child,
                  direction: AxisDirection.down, //上入下出
                  position: animation,
                );
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                //key可以理解为一个widget的唯一标签
                key: ValueKey<int>(_count),
                style: TextStyle(
                    fontSize: 100), //Theme.of(context).textTheme.headline
              ),
            ),
            RaisedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//本节我们学习了AnimatedSwitcher的详细用法，同时也介绍了打破AnimatedSwitcher动画对称性的方法。
//我们可以发现：在需要切换新旧UI元素的场景，AnimatedSwitcher将十分实用。
