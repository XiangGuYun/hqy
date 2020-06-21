import 'package:flutter/material.dart';

///CustomScrollView是可以使用Sliver来自定义滚动模型（效果）的组件。它可以包含多种滚动模型，
///举个例子，假设有一个页面，顶部需要一个GridView，底部需要一个ListView，
///而要求整个页面的滑动效果是统一的，即它们看起来是一个整体。
///如果使用GridView+ListView来实现的话，就不能保证一致的滑动效果，
///因为它们的滚动效果是分离的，所以这时就需要一个"胶水"，把这些彼此独立的可滚动组件"粘"起来，
///而CustomScrollView的功能就相当于“胶水”。

///可滚动组件的Sliver版
///Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver通常指可滚动组件子元素（就像一个个薄片一样）。
///但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，
///如果直接将ListView、GridView作为CustomScrollView是不行的，
///因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，
///Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。
///实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），
///而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，
///这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。

//头部SliverAppBar：SliverAppBar对应AppBar，
// 两者不同之处在于SliverAppBar可以集成到CustomScrollView。
// SliverAppBar可以结合FlexibleSpaceBar实现MaterialDesign中头部伸缩的模型，
//中间的SliverGrid：它用SliverPadding包裹以给SliverGrid添加补白。
// SliverGrid是一个两列，宽高比为4的网格，它有20个子组件。
//底部SliverFixedExtentList：它是一个所有子元素高度都为50像素的列表。
class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "./images/avatar.png", fit: BoxFit.cover,),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid( //Grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建子widget
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 50 //50个列表项
            ),
          ),
        ],
      ),
    );
  }
}

///滚动位置恢复
//PageStorage是一个用于保存页面(路由)相关数据的组件，它并不会影响子树的UI外观，
//其实，PageStorage是一个功能型组件，它拥有一个存储桶（bucket），
//子树中的Widget可以通过指定不同的PageStorageKey来存储各自的数据或状态。
//
//每次滚动结束，可滚动组件都会将滚动位置offset存储到PageStorage中，
//当可滚动组件重新创建时再恢复。如果ScrollController.keepScrollOffset为false，
//则滚动位置将不会被存储，可滚动组件重新创建时会使用ScrollController.initialScrollOffset；
//ScrollController.keepScrollOffset为true时，可滚动组件在第一次创建时，
//会滚动到initialScrollOffset处，因为这时还没有存储过滚动位置。
//在接下来的滚动中就会存储、恢复滚动位置，而initialScrollOffset会被忽略。
//
//当一个路由中包含多个可滚动组件时，如果你发现在进行一些跳转或切换操作后，滚动位置不能正确恢复，
//这时你可以通过显式指定PageStorageKey来分别跟踪不同的可滚动组件的位置，如：
/*
ListView(key: PageStorageKey(1), ... );
...
ListView(key: PageStorageKey(2), ... );
 */
//不同的PageStorageKey，需要不同的值，这样才可以为不同可滚动组件保存其滚动位置。
//注意：一个路由中包含多个可滚动组件时，如果要分别跟踪它们的滚动位置，
//并非一定就得给他们分别提供PageStorageKey。这是因为Scrollable本身是一个StatefulWidget，
//它的状态中也会保存当前滚动位置，所以，只要可滚动组件本身没有被从树上detach掉，
//那么其State就不会销毁(dispose)，滚动位置就不会丢失。只有当Widget发生结构变化，
//导致可滚动组件的State销毁或重新构建时才会丢失状态，这种情况就需要显式指定PageStorageKey，
//通过PageStorage来存储滚动位置，一个典型的场景是在使用TabBarView时，
//在Tab发生切换时，Tab页中的可滚动组件的State就会销毁，这时如果想恢复滚动位置就需要指定PageStorageKey。

///ScrollPosition
//ScrollPosition是用来保存可滚动组件的滚动位置的。
//一个ScrollController对象可以同时被多个可滚动组件使用，
//ScrollController会为每一个可滚动组件创建一个ScrollPosition对象，
//这些ScrollPosition保存在ScrollController的positions属性中（List<ScrollPosition>）。
//ScrollPosition是真正保存滑动位置信息的对象，offset只是一个便捷属性：
/*
double get offset => position.pixels;
 */
//一个ScrollController虽然可以对应多个可滚动组件，但是有一些操作，
//如读取滚动位置offset，则需要一对一！但是我们仍然可以在一对多的情况下，
//通过其它方法读取滚动位置，举个例子，假设一个ScrollController同时被两个可滚动组件使用，
//那么我们可以通过如下方式分别读取他们的滚动位置：
/*
...
controller.positions.elementAt(0).pixels
controller.positions.elementAt(1).pixels
...
 */
//我们可以通过controller.positions.length来确定controller被几个可滚动组件使用。
//ScrollPosition的方法
//ScrollPosition有两个常用方法：animateTo() 和 jumpTo()，
//它们是真正来控制跳转滚动位置的方法，ScrollController的这两个同名方法，内部最终都会调用ScrollPosition的。

///ScrollController控制原理
//我们来介绍一下ScrollController的另外三个方法
/*
ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition oldPosition);
void attach(ScrollPosition position) ;
void detach(ScrollPosition position) ;
 */
//当ScrollController和可滚动组件关联时，
//可滚动组件首先会调用ScrollController的createScrollPosition()方法来创建一个ScrollPosition来存储滚动位置信息，
//接着，可滚动组件会调用attach()方法，将创建的ScrollPosition添加到ScrollController的positions属性中，
//这一步称为“注册位置”，只有注册后animateTo() 和 jumpTo()才可以被调用。
//
//当可滚动组件销毁时，会调用ScrollController的detach()方法，
//将其ScrollPosition对象从ScrollController的positions属性中移除，这一步称为“注销位置”，
//注销后animateTo() 和 jumpTo() 将不能再被调用。
//
//需要注意的是，ScrollController的animateTo()和jumpTo()内部会调用
//所有ScrollPosition的animateTo()和jumpTo()，
//以实现所有和该ScrollController关联的可滚动组件都滚动到指定的位置。

/// 滚动监听
//Flutter Widget树中子Widget可以通过发送通知（Notification）与父(包括祖先)Widget通信。
//父级组件可以通过NotificationListener组件来监听自己关注的通知，
//这种通信方式类似于Web开发中浏览器的事件冒泡，我们在Flutter中沿用“冒泡”这个术语，
//关于通知冒泡我们将在后面“事件处理与通知”一章中详细介绍。
//
//可滚动组件在滚动时会发送ScrollNotification类型的通知，
//ScrollBar正是通过监听滚动通知来实现的。
//通过NotificationListener监听滚动事件和通过ScrollController有两个主要的不同：
//
//通过NotificationListener可以在从可滚动组件到widget树根之间任意位置都能监听。
//而ScrollController只能和具体的可滚动组件关联后才可以。
//收到滚动事件后获得的信息不同；NotificationListener在收到滚动事件时，
//通知中会携带当前滚动位置和ViewPort的一些信息，而ScrollController只能获取当前滚动位置。

//下面，我们监听ListView的滚动通知，然后显示当前滚动进度百分比：
class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  _ScrollNotificationTestRouteState createState() =>
      _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%"; //保存进度百分比

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar( //进度条
        // 监听滚动通知
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            //重新构建
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            //return true; //放开此行注释后，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                  itemCount: 100,
                  itemExtent: 50.0,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text("$index"));
                  }
              ),
              CircleAvatar(  //显示进度百分比
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}

//在接收到滚动事件时，参数类型为ScrollNotification，它包括一个metrics属性，
//它的类型是ScrollMetrics，该属性包含当前ViewPort及滚动位置等信息：
//
//pixels：当前滚动位置。
//maxScrollExtent：最大可滚动长度。
//extentBefore：滑出ViewPort顶部的长度；此示例中相当于顶部滑出屏幕上方的列表长度。
//extentInside：ViewPort内部长度；此示例中屏幕显示的列表部分的长度。
//extentAfter：列表中未滑入ViewPort部分的长度；此示例中列表底部未显示到屏幕范围部分的长度。
//atEdge：是否滑到了可滚动组件的边界（此示例中相当于列表顶或底部）。

//ScrollMetrics还有一些其它属性，读者可以自行查阅API文档。
