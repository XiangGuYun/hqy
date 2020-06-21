import 'package:flutter/material.dart';
import 'package:wobei/my_lib/base/BaseState.dart';

///GridView可以构建一个二维网格列表，其默认构造函数定义如下：
/*
GridView({
  Axis scrollDirection = Axis.vertical,
  bool reverse = false,
  ScrollController controller,
  bool primary,
  ScrollPhysics physics,
  bool shrinkWrap = false,
  EdgeInsetsGeometry padding,
  @required SliverGridDelegate gridDelegate, //控制子widget layout的委托
  bool addAutomaticKeepAlives = true,
  bool addRepaintBoundaries = true,
  double cacheExtent,
  List<Widget> children = const <Widget>[],
})
 */
//gridDelegate参数，类型是SliverGridDelegate，它的作用是控制GridView子组件如何排列(layout)。
//SliverGridDelegate是一个抽象类，定义了GridView Layout相关接口，
//子类需要通过实现它们来实现具体的布局算法。
//Flutter中提供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount
//和SliverGridDelegateWithMaxCrossAxisExtent，我们可以直接使用，下面我们分别来介绍一下它们。

///SliverGridDelegateWithFixedCrossAxisCount(固定副轴数量)
//该子类实现了一个横轴为固定数量子元素的layout算法，其构造函数为：
/*
SliverGridDelegateWithFixedCrossAxisCount({
  @required double crossAxisCount,//横轴子元素的数量
  double mainAxisSpacing = 0.0,//主轴方向的间距
  double crossAxisSpacing = 0.0,//横轴方向子元素的间距
  double childAspectRatio = 1.0,//子元素在横轴长度和主轴长度的比例
})
 */

class GridViewTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //横轴三个子widget
                childAspectRatio: 1.0 //宽高比为1时，子widget
                ),
            children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast)
            ]),
      ),
    );
  }
}

///GridView.count
//GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，
//我们通过它可以快速的创建横轴固定数量子元素的GridView，上面的示例代码等价于：
class GridViewTest1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast),
          ],
        ),
      ),
    );
  }
}

///SliverGridDelegateWithMaxCrossAxisExtent()最大副轴范围
//该子类实现了一个横轴子元素为固定最大长度的layout算法，其构造函数为：
/*
SliverGridDelegateWithMaxCrossAxisExtent({
  //子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的
  double maxCrossAxisExtent,
  double mainAxisSpacing = 0.0,
  double crossAxisSpacing = 0.0,
  //子元素横轴和主轴的长度比为最终的长度比
  double childAspectRatio = 1.0,
})
 */
class GridViewTest2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120.0, childAspectRatio: 2.0 //宽高比为2
              ),
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast),
          ],
        ),
      ),
    );
  }
}

///GridView.extent
//GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent，
//我们通过它可以快速的创建纵轴子元素为固定最大长度的的GridView，上面的示例代码等价于：
class GridViewTest3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.extent(
          maxCrossAxisExtent: 120.0,
          childAspectRatio: 2.0,
          children: <Widget>[
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast),
          ],
        ),
      ),
    );
  }
}

///GridView.builder
//上面我们介绍的GridView都需要一个widget数组作为其子元素，
//这些方式都会提前将所有子widget都构建好，所以只适用于子widget数量比较少时，
//当子widget比较多时，我们可以通过GridView.builder来动态创建子widget。
//GridView.builder 必须指定的参数有两个
/*
GridView.builder(
 ...
 @required SliverGridDelegate gridDelegate,
 @required IndexedWidgetBuilder itemBuilder,
)
 */

//假设我们需要从一个异步数据源（如网络）分批获取一些Icon，然后用GridView来展示：
class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => new _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //每行三列
              childAspectRatio: 1.0 //显示区域宽高相等
              ),
          itemCount: _icons.length,
          itemBuilder: (context, index) {
            //如果显示到最后一个并且Icon总数小于200时继续获取数据
            if (index == _icons.length - 1 && _icons.length < 200) {
              _retrieveIcons();
            }
            return Icon(_icons[index]);
          }),
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

///Flutter的GridView默认子元素显示空间是相等的，但在实际开发中，你可能会遇到子元素大小不等的情况
///瀑布流，Pub上有一个包“flutter_staggered_grid_view”，
///它实现了一个交错GridView的布局模型，可以很轻松的实现这种布局，详情读者可以自行了解。