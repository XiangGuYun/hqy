import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/TextLite.dart';
import 'package:wobei/widget/BlackButton.dart';
import 'package:wobei/widget/EditText.dart';
import 'package:wobei/widget/TitleBar.dart';
import '../../my_lib/extension/BaseExtension.dart';

///填写收货地址
class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          TitleBar(
            title: '填写收货信息',
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextLite(
                  '收货人',
                  color: Color(0xff6F6C7A),
                  size: 14,
                ).setSizedBox(width: 76),
                EditText(
                  50,
                  hint: '请填写收货人姓名',
                  maxLength: 10,
                  action: TextInputAction.next,
                ).setExpanded(1)
              ],
            ),
          ),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
          ).setPadding1(left: 20, right: 20),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextLite(
                  '手机号码',
                  color: Color(0xff6F6C7A),
                  size: 14,
                ).setSizedBox(width: 76),
                EditText(
                  50,
                  hint: '请填写收货人手机号',
                  maxLength: 11,
                  inputType: TextInputType.number,
                  action: TextInputAction.next,
                ).setExpanded(1)
              ],
            ),
          ),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
          ).setPadding1(left: 20, right: 20),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 50,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextLite(
                  '所在地区',
                  color: Color(0xff6F6C7A),
                  size: 14,
                ).setSizedBox(width: 76),
                TextLite(
                  '请选择所在地区',
                    color: Config.GREY_C9C8CD,
                  size: 14,
                ).setExpanded(1)
              ],
            ),
          ),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
          ).setPadding1(left: 20, right: 20),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 94,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextLite(
                  '详细地址',
                  color: Color(0xff6F6C7A),
                  size: 14,
                ).setSizedBox(width: 76).setPadding1(top: 12),
                EditText(
                  50,
                  height: 94,
                  hint: '街道、楼牌号等',
                  maxLength: 100,
                  inputType: TextInputType.text,
                  action: TextInputAction.done,
                  maxLines: 5,
                ).setExpanded(1)
              ],
            ),
          ),
          Divider(
            color: Config.DIVIDER_COLOR,
            height: 1,
          ).setPadding1(left: 20, right: 20),
          SizedBox(height: 1,).setExpanded(1),
          BlackButton(text:'确认收货信息', key: widget.key,),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
