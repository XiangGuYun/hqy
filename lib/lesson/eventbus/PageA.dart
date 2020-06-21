import 'package:flutter/material.dart';
import 'package:wobei/lesson/eventbus/PartB.dart';
import '../../my_lib/extension/BaseExtension.dart';
import '事件总线.dart';

class PageA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  var text = "初始文字";

  @override
  void initState() {
    super.initState();
    bus.on('change', (arg){
      setState(() {
        text = arg;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child:  Center(
          child: Text(text),
        ),
        onTap: (){
          context.push(PageB());
        },
      ),
    );
  }
}

