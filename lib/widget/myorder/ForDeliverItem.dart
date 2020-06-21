import 'dart:core';

import 'package:flutter/material.dart';
import 'package:wobei/my_lib/base/TextLite.dart';
import 'package:wobei/widget/VipPriceText.dart';

import '../../my_lib/extension/BaseExtension.dart';

///待发货列表项
class ForDeliverItem extends StatefulWidget {
  ///订单生存时间
  final String dateline;

  ///商品图
  final String imgUrl;

  ///商品名称
  final String productName;

  ///商品价格
  final String price;

  ForDeliverItem(
      {Key key,
        this.dateline,
        this.imgUrl,
        this.productName,
        this.price,
      }):super(key:key);

  @override
  _ForDeliverItemState createState() => _ForDeliverItemState();
}

class _ForDeliverItemState extends State<ForDeliverItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getSrnW() - 40,
      height: 202,
      decoration: BoxDecoration(
        //背景装饰
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          boxShadow: [
            //卡片阴影
            BoxShadow(
                color: Color(0x0d393649),
                offset: Offset(0.0, 4.0),
                blurRadius: 4.0)
          ]),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Text(
              widget.dateline,
              style: TextStyle(fontSize: 12, color: Color(0xffa5a3ac)),
            ),
            left: 16,
            top: 16,
          ),
          Positioned(
            child: Text(
              '待发货',
              style: TextStyle(fontSize: 14, color: '#ffb3926f'.color()),
            ),
            top: 16,
            right: 16,
          ),
          Positioned(
            child: Image.network(
              widget.imgUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            left: 16,
            top: 46,
          ),
          Positioned(
            child: TextLite(
              widget.productName,
              size: 14,
              color: Color(0xff393649),
            ),
            left: 92,
            top: 65,
          ),
          Positioned(
            child: TextLite('预计1-5个工作日内发货，请耐心等待', size: 12, color: Color(0xFFA5A3AC),),
            right: 16,
            bottom: 16,
          ),
          Positioned(
            right: 16,
            bottom: 44,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextLite(
                  '实付：',
                  color: Color(0xff393649),
                  size: 12,
                ),
                VipPriceText(
                  price: widget.price,
                  bigFontSize: 20,
                  smallFontSize: 14,
                  color: 0xff393649,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
