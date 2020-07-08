import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/widget/BlackButton.dart';
import 'package:wobei/widget/TitleBar.dart';
import 'package:wobei/widget/VipPriceText.dart';
import '../my_lib/extension/BaseExtension.dart';

///=============================================================================
///商品详情
///=============================================================================
class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with BaseUtils {
  ///标题栏不透明度
  double titleBarOpacity = 0.0;

  ///滚动监听器
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    var oneHeightOpacity = 1 / (44 + getStatusBarHeight());
    _controller.addListener(() {
      var opacity = _controller.offset * oneHeightOpacity;
      print(opacity);
      setState(() {
        if (opacity >= 0.0) {
          titleBarOpacity = min(1.0, opacity);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: _controller,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: context.getSrnW(),
                  height: context.getSrnH() / 2,
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592586160113&di=ae940df3b68edcebb57bab496d9e0191&imgtype=0&src=http%3A%2F%2Fp6.zbjimg.com%2Fservice%2F2016-07%2F02%2Fservice%2F577785a399726.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      InkWell(
                        child: Container(
                          child: Image.asset(
                            Config.BACK_BLACK,
                            width: 22,
                            height: 22,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              left: 20, top: 10 + getStatusBarHeight()),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: VipPriceText(price: '5900.00'),
                      margin: EdgeInsets.only(left: 20, top: 24),
                    ),
                    Container(
                      child: Image.asset(
                        Config.HECARD_PRICE,
                        width: 26,
                        height: 12,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(left: 4, top: 34),
                    ),
                    Container(
                      child: Text(
                        '¥ 6899.00',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffA5A3AC),
                            fontFamily: 'money'),
                      ),
                      margin: EdgeInsets.only(left: 12, top: 32),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Apple iPad Pro 11英寸 平板电脑',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff393649),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  child: Divider(
                    height: 1,
                    color: Config.DIVIDER_COLOR,
                  ),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 24),
                ),
                Container(
                  child: Text(
                      '对每商办传思指规林确温手下规两支斯来观程效听达新原况说争认市么眼声解及音叫见观标能式名将别光气每向下明满金建得使带位军变导两技有放存条此论世里过风需低个年。',
                      style: TextStyle(fontSize: 14, color: Color(0xffa5a3ac)),
                      strutStyle: StrutStyle(
                          forceStrutHeight: true, height: 1, leading: 0.5)),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 24),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 90),
                  child: Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592631697246&di=db8436bac25d51118b69aa645f9e8df7&imgtype=0&src=http%3A%2F%2Fwx4.sinaimg.cn%2Forj360%2F006okqQkgy1g8e9jndqmij30xc6fqkjn.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Opacity(
            child: Container(
              width: double.infinity,
              height: 44 + getStatusBarHeight(),
              color: Colors.white,
              alignment: Alignment.bottomLeft,
              child: TitleBar(title: '商品详情'),
            ),
            opacity: titleBarOpacity,
          ),
          Align(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Divider(height: 1, color: Config.DIVIDER_COLOR,),
                  Container(
                    child: BlackButton(
                      text: '立即购买',
                      onClickListener: (){

                      },
                    ),
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  )
                ],
              ),
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
