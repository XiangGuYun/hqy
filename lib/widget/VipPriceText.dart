import 'package:flutter/material.dart';

///=============================================================================
///会员价格文本
///=============================================================================
class VipPriceText extends StatelessWidget {
  ///大文本字体大小
  final int bigFontSize;

  ///小文本字体大小
  final int smallFontSize;

  ///价格
  final String price;

  ///文字颜色
  final int color;

  VipPriceText(
      {Key key, this.price, this.bigFontSize = 28, this.smallFontSize = 18,
      this.color = 0xffB3926F})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: '¥ ',
          style: TextStyle(
              fontSize: smallFontSize.toDouble(),
              color: Color(color),
              fontFamily: 'money')),
      TextSpan(
          text: '${price.contains('.') ? price.split('.')[0] : price}.',
          style: TextStyle(
              fontSize: bigFontSize.toDouble(),
              color: Color(color),
              fontFamily: 'money')),
      TextSpan(
          text: price.contains('.') ? price.split('.')[1] : '00',
          style: TextStyle(
              fontSize: smallFontSize.toDouble(),
              color: Color(color),
              fontFamily: 'money'))
    ]));
  }
}
