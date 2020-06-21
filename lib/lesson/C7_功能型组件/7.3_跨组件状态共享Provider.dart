import 'dart:collection';

import 'package:flutter/material.dart';

//在Flutter开发中，状态管理是一个永恒的话题。一般的原则是：
//如果状态是组件私有的，则应该由组件自己管理；如果状态要跨组件共享，
//则该状态应该由各个组件共同的父元素来管理。对于组件私有的状态管理很好理解，
//但对于跨组件共享的状态，管理的方式就比较多了，如使用全局事件总线EventBus（将在下一章中介绍），
//它是一个观察者模式的实现，通过它就可以实现跨组件状态同步：状态持有方（发布者）负责更新、发布状态，
//状态使用方（观察者）监听状态改变事件来执行一些操作。下面我们看一个登陆状态同步的简单示例：
/*
//定义事件
enum Event{
  login,
  ... //省略其它事件
}

// 登录状态改变后发布状态改变事件
bus.emit(Event.login);

void onLoginChanged(e){
  //登录状态变化处理逻辑
}

@override
void initState() {
  //订阅登录状态改变事件
  bus.on(Event.login,onLogin);
  super.initState();
}

@override
void dispose() {
  //取消订阅
  bus.off(Event.login,onLogin);
  super.dispose();
}
 */
//我们可以发现，通过观察者模式来实现跨组件状态共享有一些明显的缺点：
//
//必须显式定义各种事件，不好管理
//订阅者必须需显式注册状态改变回调，也必须在组件销毁时手动去解绑回调以避免内存泄露。

//我们可以将需要跨组件共享的状态保存在InheritedWidget中，
//然后在子组件中引用InheritedWidget即可，
//Flutter社区著名的Provider包正是基于这个思想实现的一套跨组件状态共享解决方案，
//接下来我们便详细介绍一下Provider的用法及原理。

///Provider
//首先，我们需要一个保存需要共享的数据InheritedWidget，
//由于具体业务数据类型不可预期，为了通用性，我们使用泛型，
//定义一个通用的InheritedProvider类，它继承自InheritedWidget：
// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  //共享状态使用泛型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}
//数据保存的地方有了，那么接下来我们需要做的就是在数据发生变化的时候来重新构建InheritedProvider，
//那么现在就面临两个问题：
//数据发生变化怎么通知？
//谁来重新构建InheritedProvider？
//第一个问题其实很好解决，我们当然可以使用之前介绍的eventBus来进行事件通知，
//但是为了更贴近Flutter开发，我们使用Flutter中SDK中提供的ChangeNotifier类 ，
//它继承自Listenable，也实现了一个Flutter风格的发布者-订阅者模式，ChangeNotifier定义大致如下：
/*
class ChangeNotifier implements Listenable {
  List listeners=[];
  @override
  void addListener(VoidCallback listener) {
     //添加监听器
     listeners.add(listener);
  }
  @override
  void removeListener(VoidCallback listener) {
    //移除监听器
    listeners.remove(listener);
  }

  void notifyListeners() {
    //通知所有监听器，触发监听器回调
    listeners.forEach((item)=>item());
  }

  ... //省略无关代码
}
 */
//我们可以通过调用addListener()和removeListener()来添加、移除监听器（订阅者）；
//通过调用notifyListeners() 可以触发所有监听器回调。

//现在，我们将要共享的状态放到一个Model类中，然后让它继承自ChangeNotifier，
//这样当共享的状态改变时，我们只需要调用notifyListeners() 来通知订阅者，
//然后由订阅者来重新构建InheritedProvider，这也是第二个问题的答案！接下来我们便实现这个订阅者类：
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context) {
//    final type = _typeOf<InheritedProvider<T>>();
    final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}
//该类继承StatefulWidget，然后定义了一个of()静态方法供子类方便
//获取Widget树中的InheritedProvider中保存的共享状态(model)，
//下面我们实现该类对应的_ChangeNotifierProviderState类：
class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}
//可以看到_ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
//注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
//所以执行build时，InheritedProvider的child引用的始终是同一个子widget，
//所以widget.child并不会重新build，这也就相当于对child进行了缓存！
//当然如果ChangeNotifierProvider父级Widget重新build时，则其传入的child便有可能会发生变化。

///购物车示例
//我们需要实现一个显示购物车中所有商品总价的功能：
//
//向购物车中添加新商品时总价更新
//定义一个Item类，用于表示商品信息：
class Item {
  Item(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
//... 省略其它属性
}

//定义一个保存购物车内商品数据的CartModel类:
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

//CartModel即要跨组件共享的model类。最后我们构建示例页面
class ProviderRoute extends StatefulWidget {
  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Builder(builder: (context){
                var cart=ChangeNotifierProvider.of<CartModel>(context);
                return Text("总价: ${cart.totalPrice}");
              }),
              Builder(builder: (context){
                print("RaisedButton build"); //在后面优化部分会用到
                return RaisedButton(
                  child: Text("添加商品"),
                  onPressed: () {
                    //给购物车中添加商品，添加后总价会更新
                    ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}