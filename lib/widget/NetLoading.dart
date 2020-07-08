import 'package:flutter/material.dart';
import 'package:frame_animate_widget/frame_animate_widget.dart';
import 'package:wobei/constant/Config.dart';

class NetLoading extends StatefulWidget {
  @override
  _NetLoadingState createState() => _NetLoadingState();
}

class _NetLoadingState extends State<NetLoading> {
  @override
  Widget build(BuildContext context) {
    List<String> list;

    final GlobalKey<FrameAnimationImageState> _key =
        GlobalKey<FrameAnimationImageState>();

    @override
    void initState() {
      super.initState();

    }

    @override
    void dispose() {
      super.dispose();
      _key.currentState.stopAnimation();
    }

    @override
    Widget build(BuildContext context) {
//      child: FrameAnimationImage(
//        _key,
//        list,
//        width: 50,
//        height: 50,
//        interval: 20,
//        start: true,
//      ),
      return Center(

      );
    }
  }
}
