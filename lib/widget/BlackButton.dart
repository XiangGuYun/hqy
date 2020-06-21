import 'package:flutter/material.dart';
import '../my_lib/extension/BaseExtension.dart';

class BlackButton extends StatefulWidget {
  ///按钮文本
  final String text;

  ///按钮点击事件
  final Function onClickListener;

  BlackButton({Key key, this.text, this.onClickListener}) : super(key: key);

  @override
  _BlackButtonState createState() => _BlackButtonState();
}

class _BlackButtonState extends State<BlackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClickListener,
      child: Container(
        width: context.getSrnW() - 40,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xff393649), borderRadius: BorderRadius.circular(5)),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
