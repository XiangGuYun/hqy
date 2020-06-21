import 'package:flutter/material.dart';

class PointerTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PointerTest();
  }
}

class PointerTest extends StatefulWidget {
  @override
  _PointerTestState createState() => _PointerTestState();
}

class _PointerTestState extends State<PointerTest> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300.0,
            height: 150.0,
            child: Text(_event?.position.toString() ?? "",
                style: TextStyle(color: Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) =>
              setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) =>
              setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        ),
      ),
    );
  }
}
