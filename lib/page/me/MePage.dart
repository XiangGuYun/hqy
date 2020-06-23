import 'package:flutter/material.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
/// 我的
///*****************************************************************************
class MePage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MePage>
    with AutomaticKeepAliveClientMixin, BaseUtils {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      Config.DEFAULT_BG,
                      width: context.getSrnW(),
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      Config.SETTINGS_WHITE,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    top: 10 + getStatusBarHeight(),
                    right: 64,
                  ),
                  Positioned(
                    child: Image.asset(
                      Config.MESSAGE_WHITE,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                    top: 10 + getStatusBarHeight(),
                    right: 20,
                  ),
                  Positioned(
                    child: Text(
                      '小贝的鞋匠',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    left: 20,
                    top: 50 + getStatusBarHeight(),
                  ),
                  Positioned(
                    child: Text(
                      '点击编辑个人资料',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    left: 20,
                    top: 89 + getStatusBarHeight(),
                  ),
                  Positioned(
                    child: Image.network(
                      Config.TEST_IMG,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ).setClipOval(),
                    right: 20,
                    top: 54 + getStatusBarHeight(),
                  ),
                  Positioned(
                    child: Text(
                      '240',
                      style: TextStyle(
                          fontSize: 22, color: Colors.white, fontFamily: 'money'),
                    ),
                    left: 20,
                    bottom: 122,
                  ),
                  Positioned(
                    child: Text(
                      '禾贝',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    left: 20,
                    bottom: 100,
                  ),
                  Positioned(
                    child: Text(
                      '8298.48',
                      style: TextStyle(
                          fontSize: 22, color: Colors.white, fontFamily: 'money'),
                    ),
                    left: 120,
                    bottom: 122,
                  ),
                  Positioned(
                    child: Text(
                      '零钱(元)',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    left: 120,
                    bottom: 100,
                  ),
                  Positioned(
                    child: Container(
                      width: context.getSrnW() - 40,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Config.BLACK_393649,
                      ),
                    ),
                    bottom: 0,
                    left: 20,
                    right: 20,
                  ),
                  Positioned(
                    child: Container(
                      width: 74,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          gradient: LinearGradient(
                              colors: [Color(0xFFE6BF96), Color(0xFFFFE2C0)])),
                      child: Text(
                        '立即开通',
                        style: TextStyle(
                            fontSize: 12,
                            color: Config.BLACK_303133,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    right: 35,
                    bottom: 31,
                  ),
                  Positioned(
                    child: Image.asset(
                      Config.VIP,
                      width: 16,
                      height: 14,
                      fit: BoxFit.cover,
                    ),
                    left: 35,
                    bottom: 38,
                  ),
                  Positioned(
                    child: Text(
                      '开通会员即享品质生活',
                      style: TextStyle(fontSize: 14, color: Config.GOLD_FFE2C0),
                    ),
                    bottom: 35,
                    left: 61,
                  ),
                  Positioned(
                    child: Image.asset(
                      Config.ARC,
                      width: context.getSrnW(),
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  ),
                ],
              )
                  .setColor(Colors.blueAccent)
                  .setSizedBox(width: context.getSrnW(), height: 300),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Config.RIGHT_EXCHANGE,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '权益兑换券',
                        style:
                        TextStyle(fontSize: 12, color: Config.BLACK_393649),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '8张未使用',
                        style: TextStyle(fontSize: 10, color: Config.GREY_A5A3AC),
                      ),
                    ],
                  ).setExpanded(1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Config.RED_PACKET,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '红包',
                        style:
                        TextStyle(fontSize: 12, color: Config.BLACK_393649),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '16个未使用',
                        style: TextStyle(fontSize: 10, color: Config.GREY_A5A3AC),
                      ),
                    ],
                  ).setExpanded(1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Config.VIP_EXCHANGE,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '会员兑换码',
                        style:
                        TextStyle(fontSize: 12, color: Config.BLACK_393649),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        ' ',
                        style: TextStyle(fontSize: 10, color: Config.GREY_A5A3AC),
                      ),
                    ],
                  ).setExpanded(1)
                ],
              ),
              SizedBox(
                height: 27,
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    child: Text(
                      '我的权益卡券',
                      style: TextStyle(
                          fontSize: 18,
                          color: Config.BLACK_393649,
                          fontWeight: FontWeight.w500),
                    ),
                    left: 20,
                  ),
                  Positioned(
                    child: Text(
                      '查看更多',
                      style: TextStyle(color: Config.GREY_A5A3AC, fontSize: 12),
                    ),
                    right: 32,
                    bottom: 11.5,
                  ),
                  Positioned(
                    child: Image.asset(
                      Config.DETAIL_HE_CARD,
                      width: 12,
                      height: 12,
                      fit: BoxFit.cover,
                    ),
                    right: 20,
                    bottom: 14,
                  )
                ],
              ).setSizedBox(height: 34),
              ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        Config.TEST_IMG1,
                        width: (context.getSrnW() - 52) / 2,
                        height: 121,
                        fit: BoxFit.cover,
                      ).setClipRRect(4.0),
                      SizedBox(height: 10,),
                      Text('爱奇艺钻石会员月卡', style: TextStyle(fontSize: 14, color: Config.BLACK_303133),),
                      SizedBox(height: 4,),
                      Text('有效期至2019.09.12', style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        Config.TEST_IMG1,
                        width: (context.getSrnW() - 52) / 2,
                        height: 121,
                        fit: BoxFit.cover,
                      ).setClipRRect(4.0),
                      SizedBox(height: 10,),
                      Text('爱奇艺钻石会员月卡', style: TextStyle(fontSize: 14, color: Config.BLACK_303133),),
                      SizedBox(height: 4,),
                      Text('有效期至2019.09.12', style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        Config.TEST_IMG1,
                        width: (context.getSrnW() - 52) / 2,
                        height: 121,
                        fit: BoxFit.cover,
                      ).setClipRRect(4.0),
                      SizedBox(height: 10,),
                      Text('爱奇艺钻石会员月卡', style: TextStyle(fontSize: 14, color: Config.BLACK_303133),),
                      SizedBox(height: 4,),
                      Text('有效期至2019.09.12', style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        Config.TEST_IMG1,
                        width: (context.getSrnW() - 52) / 2,
                        height: 121,
                        fit: BoxFit.cover,
                      ).setClipRRect(4.0),
                      SizedBox(height: 10,),
                      Text('爱奇艺钻石会员月卡', style: TextStyle(fontSize: 14, color: Config.BLACK_303133),),
                      SizedBox(height: 4,),
                      Text('有效期至2019.09.12', style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        Config.TEST_IMG1,
                        width: (context.getSrnW() - 52) / 2,
                        height: 121,
                        fit: BoxFit.cover,
                      ).setClipRRect(4.0),
                      SizedBox(height: 10,),
                      Text('爱奇艺钻石会员月卡', style: TextStyle(fontSize: 14, color: Config.BLACK_303133),),
                      SizedBox(height: 4,),
                      Text('有效期至2019.09.12', style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),),
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ).setSizedBox(width: double.infinity, height: 180),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
