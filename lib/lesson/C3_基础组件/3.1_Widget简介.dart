import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///概念
//在Flutter中几乎所有的对象都是一个Widget。与原生开发中“控件”不同的是，
//Flutter中的Widget的概念更广泛，它不仅可以表示UI元素，也可以表示一些功能性的组件如：
//用于手势检测的 GestureDetector widget、用于APP主题数据传递的Theme等等，
//而原生开发中的控件通常只是指UI元素。
//在后面的内容中，我们在描述UI元素时可能会用到“控件”、“组件”这样的概念，
//读者心里需要知道他们就是widget，只是在不同场景的不同表述而已。
//由于Flutter主要就是用于构建用户界面的，
//所以，在大多数时候，读者可以认为widget就是一个控件，不必纠结于概念。

///Widget与Element
//在Flutter中，Widget的功能是“描述一个UI元素的配置数据”，
//它就是说，Widget其实并不是表示最终绘制在设备屏幕上的显示元素，而它只是描述显示元素的一个配置数据。
//
//实际上，Flutter中真正代表屏幕上显示元素的类是Element，也就是说Widget只是描述Element的配置数据！
//有关Element的详细介绍我们将在本书后面的高级部分深入介绍，现在，读者只需要知道：
//Widget只是UI元素的一个配置数据，并且一个Widget可以对应多个Element。
//这是因为同一个Widget对象可以被添加到UI树的不同部分，而真正渲染时，
//UI树的每一个Element节点都会对应一个Widget对象。
//总结一下：
//Widget实际上就是Element的配置数据，Widget树实际上是一个配置树，
//而真正的UI渲染树是由Element构成；不过，由于Element是通过Widget生成的，
//所以它们之间有对应关系，在大多数场景，我们可以宽泛地认为Widget树就是指UI控件树或UI渲染树。
//一个Widget对象可以对应多个Element对象。这很好理解，根据同一份配置（Widget），可以创建多个实例（Element）。

///Widget主要接口
/*
@immutable
//Widget类继承自DiagnosticableTree，DiagnosticableTree即“诊断树”，主要作用是提供调试信息。
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  //这个key属性类似于React/Vue中的key，
  //主要的作用是决定是否在下一次build时复用旧的widget，决定的条件在canUpdate()方法中。
  final Key key;

  @protected
  //正如前文所述“一个Widget可以对应多个Element”；
  //Flutter Framework在构建UI树时，会先调用此方法生成对应节点的Element对象。
  //此方法是Flutter Framework隐式调用的，在我们开发过程中基本不会调用到。
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }

  @override
  //复写父类的方法，主要是设置诊断树的一些特性
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  //主要用于在Widget树重新build时复用旧的widget，其实具体来说，应该是：
  //是否用新的Widget对象去更新旧UI树上所对应的Element对象的配置；
  //通过其源码我们可以看到，只要newWidget与oldWidget的runtimeType和key同时相等时
  //就会用newWidget去更新Element对象的配置，否则就会创建新的Element。
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
 */
//在Flutter开发中，我们一般都不用直接继承Widget类来实现一个新组件，相反，
//我们通常会通过继承StatelessWidget或StatefulWidget来间接继承Widget类来实现。

///StatelessWidget
//StatelessWidget相对比较简单，它继承自Widget类，重写了createElement()方法：
/*
@override
StatelessElement createElement() => new StatelessElement(this);
 */
//StatelessElement 间接继承自Element类，与StatelessWidget相对应（作为其配置数据）。
//StatelessWidget用于不需要维护状态的场景，它通常在build方法中通过嵌套其它Widget来构建UI，
//在构建过程中会递归的构建其嵌套的Widget。
//实现了一个回显字符串的Echo widget。
class Echo extends StatelessWidget {
  //widget的构造函数参数应使用命名参数(传入参数时遵循“参数名:参数值”的格式)
  const Echo({
    Key key,//在继承widget时，第一个参数通常应该是Key
    @required this.text,//命名参数中的必要参数要添加@required标注
    this.backgroundColor:Colors.grey,
    //如果Widget需要接收子Widget，那么child或children参数通常应被放在参数列表的最后
  }):super(key:key);

  //Widget的属性应尽可能的被声明为final，防止被意外改变
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

///Context
//build方法有一个context参数，它是BuildContext类的一个实例，
//表示当前widget在widget树中的上下文，每一个widget都会对应一个context对象（因为每一个widget都是widget树上的一个节点）。
//实际上，context是当前widget在widget树中位置中执行”相关操作“的一个句柄，
//比如它提供了从当前widget开始向上遍历widget树以及按照widget类型查找父级widget的方法。

//下面是在子树中获取父级widget的一个示例
class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

///StatefulWidget
//和StatelessWidget一样，StatefulWidget也是继承自Widget类，并重写了createElement()方法，
//不同的是返回的Element对象并不相同；另外StatefulWidget类中添加了一个新的接口createState()。
//下面我们看看StatefulWidget的类定义：
/*
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key key }) : super(key: key);

  @override
  //StatefulElement间接继承自Element类，与StatefulWidget相对应（作为其配置数据）。
  //StatefulElement中可能会多次调用createState()来创建状态(State)对象
  StatefulElement createElement() => new StatefulElement(this);

  @protected
  //用于创建和Stateful widget相关的状态，它在Stateful widget的生命周期中可能会被多次调用。
  //例如，当一个Stateful widget同时插入到widget树的多个位置时，
  //Flutter framework就会调用该方法为每一个位置生成一个独立的State实例，
  //其实，本质上就是一个StatefulElement对应一个State实例
  State createState();
}
 */

///State
//一个StatefulWidget类会对应一个State类，State表示与其对应的StatefulWidget要维护的状态，
//
//State中的保存的状态信息可以：
//1.在widget构建时可以被同步读取。
//2.在widget生命周期中可以被改变，当State被改变时，
//可以手动调用其setState()方法通知Flutter framework状态发生改变，
//Flutter framework在收到消息后，会重新调用其build方法重新构建widget树，从而达到更新UI的目的。
//
//State中有两个常用属性:
//1.widget:表示与该State实例关联的widget实例，由Flutter framework动态设置。
//注意，这种关联并非永久的，因为在应用生命周期中，UI树上的某一个节点的widget实例在重新构建时可能会变化，
//但State实例只会在第一次插入到树中时被创建，当在重新构建时，如果widget被修改了，
//Flutter framework会动态设置State.widget为新的widget实例。
//2.context:StatefulWidget对应的BuildContext，作用同StatelessWidget的BuildContext。

///State生命周期
//理解State的生命周期对flutter开发非常重要，为了加深读者印象，
//本节我们通过一个实例来演示一下State的生命周期。
//在接下来的示例中，我们实现一个计数器widget，点击它可以使计数器加1，由于要保存计数器的数值状态，
//所以我们应继承StatefulWidget，代码如下：
class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}
//CounterWidget接收一个initValue整型参数，它表示计数器的初始值。下面我们看一下State的代码：
class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  //当Widget第一次插入到Widget树时会被调用，对于每一个State对象，
  //Flutter framework只会调用一次该回调，
  //所以，通常在该回调中做一些一次性的操作，
  //如状态初始化、订阅子树的事件通知等。
  //不能在该回调中调用BuildContext.dependOnInheritedWidgetOfExactType
  //（该方法用于在Widget树上获取离当前widget最近的一个父级InheritFromWidget，
  //关于InheritedWidget我们将在后面章节介绍），原因是在初始化完成后，
  //Widget树中的InheritFromWidget也可能会发生变化，
  //所以正确的做法应该在在build()方法或didChangeDependencies()中调用它。
  void initState() {
    super.initState();
    //初始化状态
    _counter=widget.initValue;
    print("initState");
  }

  @override
  //它主要是用于构建Widget子树的，会在如下场景被调用：
  //调用initState()之后。
  //在调用didUpdateWidget()之后。
  //在调用setState()之后。
  //在调用didChangeDependencies()之后。
  //在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed:()=>setState(()=> ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  //在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，
  //然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。正如之前所述，
  //Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，
  //也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  //当State对象从树中被移除时，会调用此回调。在一些场景下，
  //Flutter framework会将State对象重新插到树中，
  //如包含此State对象的子树在树的一个位置移动到另一个位置时（可以通过GlobalKey来实现）。
  //如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  //当State对象从树中被永久移除时调用；通常在此回调中释放资源。
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  //此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，
  //此回调在Release模式下永远不会被调用。
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}
//接下来，我们创建一个新页面，只显示一个CounterWidget：
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CounterWidget();
  }
}
//在新路由页打开后，屏幕中央就会出现一个数字0，然后控制台日志输出：
/*
I/flutter ( 3877): initState
I/flutter ( 3877): didChangeDependencies
I/flutter ( 3877): build
 */
//然后我们点击⚡️按钮热重载，控制台输出日志如下：
/*
I/flutter ( 3877): reassemble
I/flutter ( 3877): didUpdateWidget
I/flutter ( 3877): build
 */
//接下来，我们在widget树中移除CounterWidget，将路由build方法改为：
/*
Widget build(BuildContext context) {
  //移除计数器
  //return CounterWidget();
  //随便返回一个Text()
  return Text("xxx");
}
 */
//然后热重载，日志如下：
/*
I/flutter ( 5436): reassemble
I/flutter ( 5436): deactive
I/flutter ( 5436): dispose
 */
//StatefulWidget的生命周期见图：https://pcdn.flutterchina.club/imgs/3-2.jpg
//注意：在继承StatefulWidget重写其方法时，对于包含@mustCallSuper标注的父类方法，
//都要在子类方法中先调用父类方法。

///在Widget树中获取State对象

//通过Context获取
//context对象有一个findAncestorStateOfType()方法，
//该方法可以从当前节点沿着widget树向上查找指定类型的StatefulWidget对应的State对象。
//下面是实现打开SnackBar的示例：
class OpenSnackBarPage extends StatefulWidget {
  @override
  _OpenSnackBarPageState createState() => _OpenSnackBarPageState();
}

class _OpenSnackBarPageState extends State<OpenSnackBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              //查找父级最近的Scaffold对应的ScaffoldState对象
              ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
              //调用ScaffoldState的showSnackBar来弹出SnackBar
              _state.showSnackBar(
                SnackBar(
                  content: Text("我是SnackBar"),
                ),
              );
            },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}

//通过GlobalKey
//1.给目标StatefulWidget添加GlobalKey。
/*
//定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
static GlobalKey<ScaffoldState> _globalKey= GlobalKey();
...
Scaffold(
    key: _globalKey , //设置key
    ...
)
 */
//通过GlobalKey来获取State对象
/*
_globalKey.currentState.openDrawer()
 */
//GlobalKey是Flutter提供的一种在整个APP中引用element的机制。
//如果一个widget设置了GlobalKey，那么我们便可以通过globalKey.currentWidget获得该widget对象、
//globalKey.currentElement来获得widget对应的element对象，如果当前widget是StatefulWidget，
//则可以通过globalKey.currentState来获得该widget对应的state对象。
//注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。
//另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。

///Flutter SDK内置组件库介绍
//Flutter提供了一套丰富、强大的基础组件，在基础组件库之上Flutter又提供了一套Material风格
//（Android默认的视觉风格）和一套Cupertino风格（iOS视觉风格）的组件库
//要使用基础组件库，需要先导入：
/*
import 'package:flutter/widgets.dart';
 */

//基础组件
//1.Text：该组件可让您创建一个带格式的文本。
//Row、 Column： 这些具有弹性空间的布局类Widget可让您在水平（Row）和垂直（Column）方向上创建灵活的布局。
//其设计是基于Web开发中的Flexbox布局模型。
//2.Stack： 取代线性布局 (译者语：和Android中的FrameLayout相似)，Stack允许子 widget 堆叠，
//你可以使用 Positioned 来定位他们相对于Stack的上下左右四条边的位置。
//3.Stacks是基于Web开发中的绝对定位（absolute positioning )布局模型设计的。
//4.Container： Container 可让您创建矩形视觉元素。container 可以装饰一个BoxDecoration,
//如background、一个边框、或者一个阴影。 Container 也可以具有边距（margins）、填充(padding)
//和应用于其大小的约束(constraints)。另外， Container可以使用矩阵在三维空间中对其进行变换。

//Material组件
//Flutter提供了一套丰富的Material组件，它可以帮助我们构建遵循Material Design设计规范的应用程序。
//Material应用程序以MaterialApp 组件开始， 该组件在应用程序的根部创建了一些必要的组件，
//比如Theme组件，它用于配置应用的主题。 是否使用MaterialApp完全是可选的，但是使用它是一个很好的做法。
/*
import 'package:flutter/material.dart';
 */

//Cupertino组件
//Flutter也提供了一套丰富的Cupertino风格的组件，尽管目前还没有Material 组件那么丰富，但是它仍在不断的完善中。
//值得一提的是在Material 组件库中有一些组件可以根据实际运行平台来切换表现风格，比如MaterialPageRoute
//下面我们实现一个简单的Cupertino组件风格的页面：
class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}
        ),
      ),
    );
  }
}