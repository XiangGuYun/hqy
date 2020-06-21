//Material组件库中提供了Material风格的单选开关Switch和复选框Checkbox，
//虽然它们都是继承自StatefulWidget，但它们本身不会保存当前选中状态，选中状态都是由父组件来管理的。
//当Switch或Checkbox被点击时，会触发它们的onChanged回调，我们可以在此回调中处理选中状态改变逻辑。
//下面看一个简单的例子：
import 'package:flutter/material.dart';

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() =>
      new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: _switchSelected, //当前状态
              onChanged: (value) {
                //重新构建页面
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
            Checkbox(
              value: _checkboxSelected,
              activeColor: Colors.red, //选中时的颜色
              onChanged: (value) {
                setState(() {
                  _checkboxSelected = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
//上面代码中，由于需要维护Switch和Checkbox的选中状态，所以SwitchAndCheckBoxTestRoute继承自StatefulWidget。
//在其build方法中分别构建了一个Switch和Checkbox，初始状态都为选中状态，当用户点击时，会将状态置反，
//然后回调用setState()通知Flutter framework重新构建UI。

//属性及外观
//Switch和Checkbox属性比较简单，读者可以查看API文档，它们都有一个activeColor属性，
//用于设置激活态的颜色。至于大小，到目前为止，Checkbox的大小是固定的，无法自定义，
//而Switch只能定义宽度，高度也是固定的。值得一提的是Checkbox有一个属性tristate，
//表示是否为三态，其默认值为false ，这时Checkbox有两种状态即“选中”和“不选中”，
//对应的value值为true和false 。如果tristate值为true时，value的值会增加一个状态null，读者可以自行了解。