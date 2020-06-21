
import 'package:flutter/material.dart';

class TextLite extends StatelessWidget {

  final String data;
  final int size;
  final Color color;

  TextLite(this.data, {Key key, this.size, this.color}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: TextStyle(fontSize: size.toDouble(), color: color),);
  }
}
