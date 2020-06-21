import 'package:flutter/material.dart';
import 'package:wobei/my_lib/base/TextLite.dart';
import 'package:wobei/widget/VipPriceText.dart';
import '../../my_lib/extension/BaseExtension.dart';


///已完成列表项
class CompletedItem extends StatefulWidget {

  ///订单生存时间
  final String dateline;

  ///商品图
  final String imgUrl;

  ///商品名称
  final String productName;

  ///商品价格
  final String price;

  CompletedItem(
      {Key key,
        this.dateline,
        this.imgUrl,
        this.productName,
        this.price,
        }):super(key:key);

  @override
  _CompletedItemState createState() => _CompletedItemState();
}

class _CompletedItemState extends State<CompletedItem> {
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
              '已完成',
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
            bottom: 16,
            right: 16,
            child: Container(
              alignment: Alignment.center,
              child: TextLite(
                '查看物流',
                color: Color(0xff393649),
                size: 12,
              ),
              width: 68,
              height: 28,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff393649), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 60,
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
