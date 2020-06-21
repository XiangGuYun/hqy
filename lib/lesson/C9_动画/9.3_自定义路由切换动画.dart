import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteAnimPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('跳转'),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => RouteAnimPage2(),
                ));
          },
        ),
      ),
    );
  }
}

class RouteAnimPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

//下面我们来看看如何使用PageRouteBuilder来自定义路由切换动画。
//例如我们想以渐隐渐入动画来实现路由过渡，实现代码如下：
class RouteAnimPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            'http://pic.netbian.com/uploads/allimg/200503/220049-1588514449b348.jpg',
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return FadeTransition(
                    //使用渐隐渐入过渡,
                    opacity: animation,
                    child: RouteAnimPage2(), //路由B
                  );
                },
              ));
        },
      ),
    );
  }
}

//无论是MaterialPageRoute、CupertinoPageRoute，还是PageRouteBuilder，它们都继承自PageRoute类，
//而PageRouteBuilder其实只是PageRoute的一个包装，我们可以直接继承PageRoute类来实现自定义路由，
//上面的例子可以通过如下方式实现：
class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) => builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

class RouteAnimPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            'http://pic.netbian.com/uploads/allimg/200503/220049-1588514449b348.jpg',
            fit: BoxFit.cover,
          ),
        ),
        onTap: () {
          Navigator.push(context, FadeRoute(builder: (context) {
            return RouteAnimPage2();
          }));
        },
      ),
    );
  }
}

//虽然上面的两种方法都可以实现自定义切换动画，但实际使用时应优先考虑使用PageRouteBuilder，
//这样无需定义一个新的路由类，使用起来会比较方便。但是有些时候PageRouteBuilder是不能满足需求的，
//例如在应用过渡动画时我们需要读取当前路由的一些属性，这时就只能通过继承PageRoute的方式了，
//举个例子，假如我们只想在打开新路由时应用动画，而在返回时不使用动画，
//那么我们在构建过渡动画时就必须判断当前路由isActive属性是否为true，代码如下：
/*
@override
Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
 //当前路由被激活，是打开新路由
 if(isActive) {
   return FadeTransition(
     opacity: animation,
     child: builder(context),
   );
 }else{
   //是返回，则不应用过渡动画
   return Padding(padding: EdgeInsets.zero);
 }
}
 */
