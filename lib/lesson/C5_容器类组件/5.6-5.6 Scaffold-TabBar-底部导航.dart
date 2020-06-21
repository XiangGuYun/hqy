import 'package:flutter/material.dart';

///Material组件库提供了丰富多样的组件，本节介绍一些常用的组件，
///其余的读者可以自行查看文档或Flutter Gallery中Material组件部分的示例。

///Flutter Gallery是Flutter官方提供的Flutter Demo，
///源码位于flutter源码中的examples目录下，笔者强烈建议用户将Flutter Gallery示例跑起来，
///它是一个很全面的Flutter示例应用，是非常好的参考Demo，也是笔者学习Flutter的第一手资料。

///Scaffold(支架，骨架，脚手架)
///一个完整的路由页可能会包含导航栏、抽屉菜单(Drawer)以及底部Tab导航菜单等。
///如果每个路由页面都需要开发者自己手动去实现这些，这会是一件非常麻烦且无聊的事。
///幸运的是，Flutter Material组件库提供了一些现成的组件来减少我们的开发任务。
///Scaffold是一个路由页的骨架，我们使用它可以很容易地拼装出一个完整的页面。

///示例
//我们实现一个页面，它包含：
//
//一个导航栏
//导航栏右边有一个分享按钮
//有一个抽屉菜单
//有一个底部导航
//右下角有一个悬浮的动作按钮
class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //导航栏
        title: Text("App Name"),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      drawer: Drawer(), //抽屉
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton( //悬浮按钮
          child: Icon(Icons.add),
          onPressed:_onAdd
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onAdd(){
  }
}

///上面代码中我们用到了如下组件：
//组件名称	解释
//AppBar	一个导航栏骨架
//Drawer	抽屉菜单
//BottomNavigationBar	底部导航栏
//FloatingActionButton	漂浮按钮
//下面我们来分别介绍一下它们。

///AppBar
///AppBar是一个Material风格的导航栏，
///通过它可以设置导航栏标题、导航栏菜单、导航栏底部的Tab标题等。
///下面我们看看AppBar的定义：
/*
AppBar({
  Key key,
  this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
  this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
  this.title,// 页面标题
  this.actions, // 导航栏右侧菜单
  this.bottom, // 导航栏底部菜单，通常为Tab按钮组
  this.elevation = 4.0, // 导航栏阴影
  this.centerTitle, //标题是否居中
  this.backgroundColor,
  ...   //其它属性见源码注释
})
 */
///如果给Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮，
///点击它便可打开抽屉菜单。如果我们想自定义菜单图标，可以手动来设置leading，如：
/*
Scaffold(
  appBar: AppBar(
    title: Text("App Name"),
    leading: Builder(builder: (context) {
      return IconButton(
        icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
        onPressed: () {
          // 打开抽屉菜单
          Scaffold.of(context).openDrawer();
        },
      );
    }),
    ...
  )
 */
