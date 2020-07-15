import 'package:flutter/material.dart';
import 'package:wobei/bean/MeData.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/constant/Config.dart';
import 'package:wobei/lesson/eventbus/EventBus.dart';
import 'package:wobei/widget/TitleBar.dart';

///*****************************************************************************
///
/// 个人资料
///
///*****************************************************************************
class PersonalInfoPage extends StatefulWidget {
  final MeData arguments;

  PersonalInfoPage({this.arguments = null});

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

  /// 是否已实名
  var valueCertification = false;

  @override
  void initState() {
    super.initState();
    bus.on('PersonalInfoPage', (arg) {
      if(arg == 'certificated'){
        setState(() {
          valueCertification = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            TitleBar(
              title: '个人资料',
            ),
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Align(
                      child: Text(
                        '头像',
                        style:
                        TextStyle(fontSize: 16, color: Config.BLACK_303133),
                      ),
                      alignment: Alignment(-1, 0),
                    ),
                    top: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child:  ClipOval(
                      child: getAvatarImg(),
                    ),
                    right: 22,
                    top: 10,
                    bottom: 10,
                  ),
                  Positioned(
                    child:  Image.asset(Config.DETAIL_LIGHT, width: 12, height: 12,),
                    right: 0,
                    top: 24,
                    bottom: 24,
                  )
                ],
              ),
            ),
            Divider(height: 1, color: Config.DIVIDER_COLOR, indent: 20, endIndent: 20,),
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Align(
                      child: Text(
                        '昵称',
                        style:
                        TextStyle(fontSize: 16, color: Config.BLACK_303133),
                      ),
                      alignment: Alignment(-1, 0),
                    ),
                    top: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        widget.arguments==null?'':widget.arguments.nickname,
                        style: TextStyle(fontSize: 16, color: Config.GREY_909399),
                      ),
                    ),
                    right: 22,
                    top: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child:  Image.asset(Config.DETAIL_LIGHT, width: 12, height: 12,),
                    right: 0,
                    top: 24,
                    bottom: 24,
                  )
                ],
              ),
            ),
            Divider(height: 1, color: Config.DIVIDER_COLOR, indent: 20, endIndent: 20,),
            Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Align(
                        child: Text(
                          '实名认证',
                          style:
                          TextStyle(fontSize: 16, color: Config.BLACK_303133),
                        ),
                        alignment: Alignment(-1, 0),
                      ),
                      top: 0,
                      bottom: 0,
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment(-1, 0),
                        child: Text(
                          widget.arguments.certStatus==1 || valueCertification ?'已实名':'未实名',
                          style: TextStyle(fontSize: 16, color: Config.GREY_909399),
                        ),
                      ),
                      right: 22,
                      top: 0,
                      bottom: 0,
                    ),
                    Positioned(
                      child:  Image.asset(Config.DETAIL_LIGHT, width: 12, height: 12,),
                      right: 0,
                      top: 24,
                      bottom: 24,
                    )
                  ],
                ),
                onTap: _goToCertification,
              ),
            ),
            Divider(height: 1, color: Config.DIVIDER_COLOR, indent: 20, endIndent: 20,),
          ],
        ),
      ),
    );
  }

  Widget getItem(String name, Widget rightWidget) {
    return Container(
      child: Stack(
        children: <Widget>[],
      ),
    );
  }

  Widget getAvatarImg() {
    if (widget.arguments == null) {
      return Image.asset(
        Config.DEFAULT_AVATAR,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        widget.arguments.headPicture,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      );
    }
  }

  ///---------------------------------------------------------------------------
  /// 前往实名认证
  ///---------------------------------------------------------------------------
  void _goToCertification() {
    if(widget.arguments.certStatus==1){
      return;
    }
    Navigator.of(context).pushNamed(AppRoute.CERTIFICATION_PAGE);
  }
}
