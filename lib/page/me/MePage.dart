import 'package:flutter/material.dart';

///*****************************************************************************
/// 我的
///*****************************************************************************
class MePage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: Text('Me'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

