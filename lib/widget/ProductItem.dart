import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import '../my_lib/extension/BaseExtension.dart';

///=============================================================================
///商品列表项，包含会员价和原价
///```dart
///ProductItem(
///   productTitle: "某某商品1223这是一个好故事叭叭叭",
///   vipPrice: "12.00",
///   originPrice: '14.50',
///   imgUrl: 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=15857274,120780525&fm=26&gp=0.jpg',
///),
///```
///=============================================================================
class ProductItem extends StatefulWidget {
  ///商品标题
  final String productTitle;

  ///会员价格
  final String vipPrice;

  ///商品图片地址
  final String imgUrl;

  ///原价
  final String originPrice;

  ProductItem({Key key, this.productTitle, this.vipPrice, this.imgUrl, this.originPrice}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> with BaseUtils {
  ///会员价格整数部分
  String vipPriceInteger;

  ///会员价格小数部分
  String vipPriceDemical;

  @override
  void initState() {
    super.initState();
    if (widget.vipPrice.isNotEmpty) {
      if (widget.vipPrice.contains('.')) {
        var arr = widget.vipPrice.split('.');
        vipPriceInteger = arr[0];
        vipPriceDemical = arr[1];
      } else {
        vipPriceInteger = widget.vipPrice;
        vipPriceDemical = '00';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getSrnW() - 40,
      height: 124,
      decoration: BoxDecoration(//背景装饰
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [ //卡片阴影
            BoxShadow(
                color: Color(0x0d393649),
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0
            )
          ]
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              widget.productTitle,
              style: TextStyle(fontSize: 16, color: Color(0xff393649), fontWeight: FontWeight.w400),
            ),
            width: context.getSrnW() - 190,
            margin: EdgeInsets.only(left: 128, top: 14),
          ),
          Container(
            alignment: Alignment(-1, 1),
            margin: EdgeInsets.only(left: 127.5, bottom: 14),
            child: Row(
              children: <Widget>[
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '¥',
                      style: TextStyle(fontSize: 14, color: Color(0xFFB3926F), fontFamily: 'money')),
                  TextSpan(
                      text: '$vipPriceInteger.',
                      style: TextStyle(fontSize: 20, color: Color(0xFFB3926F), fontFamily: 'money')),
                  TextSpan(
                      text: vipPriceDemical,
                      style: TextStyle(fontSize: 14, color: Color(0xFFB3926F), fontFamily: 'money'))
                ])),
                SizedBox(width: 4.5,),
                Image.asset(Config.HECARD_PRICE, width: 22, height: 10, fit: BoxFit.cover,),
                SizedBox(width: 11.5,),
                Text('¥${widget.originPrice}', style: TextStyle(fontSize: 14, color: Color(0xffa5a3ac), fontFamily: 'money'),)
              ],
            ),
          ),
          Container(
            child: Image.network(
              widget.imgUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            margin: EdgeInsets.only(left: 12, top: 12),
          ),
        ],
      ),
    );
  }
}
