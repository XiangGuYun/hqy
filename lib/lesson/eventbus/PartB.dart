import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'EventBus.dart';

class PageB extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: RaisedButton(
              child: Text('BACK')
          ),
        ),
        onTap: (){
          bus.emit('change', '当前时间：${formatDate(
              DateTime.now(), [HH, ':', nn, ':', ss])}');
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

