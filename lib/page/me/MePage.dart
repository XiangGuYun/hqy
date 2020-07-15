import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wobei/bean/MeData.dart';
import 'package:wobei/bean/MyCardData.dart';
import 'package:wobei/bean/Pair.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/eventbus/EventBus.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import 'package:wobei/my_lib/utils/AvatarUtils.dart';

import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
///
/// 我的
///
///*****************************************************************************
class MePage extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MePage>
    with AutomaticKeepAliveClientMixin, BaseUtils {
  String valueNickName = '';

  String valueHeBei = '';

  String valueMoney = '';

  /// 背景图片，会员区别于非会员
  String backgroundImg = Config.DEFAULT_BG;

  var valueAvatarImg = '';

  MeData me = null;

  final avatarUtils = AvatarUtils();

  String textBlackboard = '开通会员即享品质生活';

  var isVip = false;

  /// 会员有效期
  var vipValidity = '';

  int valueExchangeUnUse = 0;

  int valueRedPacketUnUse = 0;

  bool myCardListIsEmpty = true;

  List<Result> cardList = [];

  /// 是否有企业专区
  bool haveEnterprisePrefecture = false;

  /// 企业名称
  var enterpriseName = '';

  @override
  void initState() {
    super.initState();
    bus.on('MePage', (arg) {
      Pair pair = arg;
      switch (pair.first) {
        case 'nickname':
          setState(() {
            valueNickName = pair.second;
          });
          break;
        case 'updateMe':
          setState(() {
            valueAvatarImg = pair.second;
          });
          break;
      }
    });
    getMeInfo();
    Req.getMyCard((MyCardData data) {
      if (data.results.length == 0) {
        setState(() {
          myCardListIsEmpty = true;
        });
      } else {
        setState(() {
          myCardListIsEmpty = false;
          if (data.results.length >= 6) {
            cardList = data.results.sublist(0, 6);
          } else {
            cardList = data.results;
          }
        });
      }
    });
    Req.viewMyEnterpriseInfo((id, name) {
      setState(() {
        if (id == -1) {
          haveEnterprisePrefecture = false;
        } else {
          haveEnterprisePrefecture = true;
          enterpriseName = name;
        }
      });
    });
  }

  void getMeInfo() {
    Req.getMeInfo((MeData me) {
      this.me = me;
      setState(() {
        // 昵称
        valueNickName = me.nickname;
        // 禾贝余额
        valueHeBei = me.totalScore;
        // 零钱余额
        valueMoney = me.totalMoney;
        // 头像
        valueAvatarImg = me.headPicture;
        // 兑换券未使用数量
        valueExchangeUnUse = me.throneCardNotUseNum;
        // 红包未使用数量
        valueRedPacketUnUse = me.welfareCardNotUseNum;
        // 会员状态
        switch (me.state) {
          case '1': // 已过期
            isVip = false;
            Global.prefs.setString('vip', '0');
            if (backgroundImg != Config.DEFAULT_BG) {
              backgroundImg = Config.DEFAULT_BG;
              textBlackboard = '开通会员即享品质生活';
            }
            break;
          case '2': // 进行中
            isVip = true;
            Global.prefs.setString('vip', '1');
            backgroundImg = Config.HECARDVIP_BG;
            textBlackboard = '禾卡会员';
            if (me.dueTimeDay == -1) {
              vipValidity =
                  '有效期至 ${me.dueTime.replaceAll('00:00:00', '').trim()}';
            } else {
              vipValidity = "${me.dueTimeDay}天后到期，立即续费";
            }
            break;
          case '3': // 非会员
            isVip = false;
            Global.prefs.setString('vip', '0');
            if (backgroundImg != Config.DEFAULT_BG) {
              backgroundImg = Config.DEFAULT_BG;
              textBlackboard = '开通会员即享品质生活';
            }
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawerScrimColor: Colors.white,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    backgroundImg,
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
                  ).setGestureDetector(onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.SETTINGS_PAGE);
                  }),
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
                  child: GestureDetector(
                    child: Text(
                      valueNickName,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoute.PERSONAL_INFO, arguments: me);
                    },
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
                  child: getAvatar(valueAvatarImg)
                      .setClipOval()
                      .setGestureDetector(onTap: () {
                    avatarUtils.showSelectPhotoDialog(context, (file) {
                      Req.uploadAvatar(file, (url) {
                        setState(() {
                          valueAvatarImg = url;
                        });
                      });
                    });
                  }),
                  right: 20,
                  top: 54 + getStatusBarHeight(),
                ),
                Positioned(
                  child: Text(
                    valueHeBei,
                    style: TextStyle(
                        fontSize: 22, color: Colors.white, fontFamily: 'money'),
                  )
                      .setConstrainedBox(minWidth: 100.0, minHeight: 10.0)
                      .setGestureDetector(onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.HE_BEI_SHOP_PAGE);
                  }),
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
                    valueMoney,
                    style: TextStyle(
                        fontSize: 22, color: Colors.white, fontFamily: 'money'),
                  )
                      .setConstrainedBox(minWidth: 100.0, minHeight: 10.0)
                      .setGestureDetector(onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.MY_PACKET_PAGE);
                  }),
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
                  ).setGestureDetector(onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.BUY_VIP_PAGE);
                  }),
                  bottom: 0,
                  left: 20,
                  right: 20,
                ),
                Positioned(
                  child: getBlackboardRightText(),
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
                    textBlackboard,
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
            ).setSizedBox(width: context.getSrnW(), height: 300),
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
                      '$valueExchangeUnUse张未使用',
                      style: TextStyle(fontSize: 10, color: Config.GREY_A5A3AC),
                    ),
                  ],
                ).setGestureDetector(onTap: () {
                  Navigator.of(context).pushNamed(AppRoute.RIGHT_EXCHANGE_PAGE);
                }).setExpanded(1),
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
                      '$valueRedPacketUnUse个未使用',
                      style: TextStyle(fontSize: 10, color: Config.GREY_A5A3AC),
                    ),
                  ],
                ).setGestureDetector(onTap: () {
                  Navigator.of(context).pushNamed(AppRoute.RED_PACKET_PAGE);
                }).setExpanded(1),
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
                ).setGestureDetector(onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.VIP_EXCHANGE_CODE_PAGE);
                }).setExpanded(1)
              ],
            ),
            getEnterprisePrefecture(),
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
                  ).setGestureDetector(onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoute.MY_CARD_TICKET_PAGE);
                  }),
                  right: 32,
                  bottom: 11.5,
                ),
                Positioned(
                  child: Image.asset(
                    Config.DETAIL_HECARD,
                    width: 12,
                    height: 12,
                    fit: BoxFit.cover,
                  ),
                  right: 20,
                  bottom: 14,
                )
              ],
            ).setSizedBox(height: 34),
            getMyRightCardList(),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget getAvatar(String valueAvatarImg) {
    return valueAvatarImg.isEmpty
        ? Image.asset(
            Config.DEFAULT_AVATAR,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          )
        : Image.network(
            valueAvatarImg,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          );
  }

  ///---------------------------------------------------------------------------
  /// 获取黑板右侧文字
  ///---------------------------------------------------------------------------
  Widget getBlackboardRightText() {
    if (!isVip) {
      return Container(
        child: Text(
          '立即开通',
          style: TextStyle(
              fontSize: 12,
              color: Config.BLACK_303133,
              fontWeight: FontWeight.w500),
        ),
        width: 74,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            gradient:
                LinearGradient(colors: [Color(0xFFE6BF96), Color(0xFFFFE2C0)])),
      );
    } else {
      return Text(vipValidity,
          style: TextStyle(
            fontSize: 14,
            color: Config.GOLD_FFE2C0,
          ));
    }
  }

  ///---------------------------------------------------------------------------
  /// 获取我的权益卡券列表
  ///---------------------------------------------------------------------------
  Widget getMyRightCardList() {
    if (myCardListIsEmpty) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            '一个空空的卡包',
            style: TextStyle(fontSize: 22, color: Color(0xffc0c4cc)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 86,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '去淘卡券',
              style: TextStyle(fontSize: 14, color: Config.BLACK_303133),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Config.BLACK_303133, width: 1)),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: cardList.length,
          itemBuilder: (context, index) {
            return Row(
              children: <Widget>[
                SizedBox(
                  width: index == 0 ? 20 : 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      cardList[index].logo,
                      width: (context.getSrnW() - 52) / 2,
                      height: 121,
                      fit: BoxFit.cover,
                    ).setClipRRect(4.0),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      cardList[index].itemName.maxLength(11),
                      style:
                          TextStyle(fontSize: 14, color: Config.BLACK_303133),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '有效期至${formatDate(DateTime.fromMillisecondsSinceEpoch(cardList[index].exchangEndTime), [
                        yyyy,
                        '年',
                        mm,
                        '月',
                        dd,
                        '日'
                      ])}',
                      style: TextStyle(fontSize: 12, color: Config.GREY_A5A3AC),
                    ),
                  ],
                ).setGestureDetector(onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoute.CARD_TICKET_DETAIL_PAGE);
                }),
                SizedBox(
                  width: index == cardList.length - 1 ? 20 : 0,
                ),
              ],
            );
          }).setSizedBox(width: double.infinity, height: 180);
    }
  }

  ///---------------------------------------------------------------------------
  /// 获取企业专区
  ///---------------------------------------------------------------------------
  Widget getEnterprisePrefecture() {
    if (haveEnterprisePrefecture) {
      return Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              height: 90,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    Config.OVAL,
                    width: double.infinity,
                    height: 90,
                    fit: BoxFit.cover,
                  ).setClipRRect(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          enterpriseName,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        alignment: Alignment(0, -1),
                        margin: EdgeInsets.only(top: 16),
                      ),
                      SizedBox(
                        height: 1,
                      ).setExpanded(1),
                      Container(
                        width: 90,
                        child: Row(
                          children: <Widget>[
                            Wrap(
                             children: <Widget>[ Text(
                               '进入企业专区',
                               style: TextStyle(
                                   fontSize: 12, color: Color(0xcdffffff)),
                             )],
                            ),
                            Image.asset(
                              Config.DETAIL_LIGHT,
                              width: 12,
                              height: 12,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ).setGestureDetector(onTap: (){
        Navigator.of(context).pushNamed(AppRoute.ENTERPRISE_PREFECTURE_PAGE);
      });
    } else {
      return SizedBox(
        height: 27,
      );
    }
  }
}
