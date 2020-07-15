import 'package:flutter/material.dart';
import 'package:wobei/bean/MeData.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/my_lib/RouteAnim.dart';
import 'package:wobei/page/WebPage.dart';
import 'package:wobei/page/home/SearchPage.dart';
import 'package:wobei/page/intro/ADPage.dart';
import 'package:wobei/page/intro/WelcomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/me/BuyVipPage.dart';
import 'package:wobei/page/me/CardTicketDetailPage.dart';
import 'package:wobei/page/me/CertificationPage.dart';
import 'package:wobei/page/me/EnterprisePrefecturePage.dart';
import 'package:wobei/page/me/HeBeiAboutPage.dart';
import 'package:wobei/page/me/HeBeiShopPage.dart';
import 'package:wobei/page/me/MyCardTicketPage.dart';
import 'package:wobei/page/me/MyPacketPage.dart';
import 'package:wobei/page/me/NickNamePage.dart';
import 'package:wobei/page/me/PersonalInfoPage.dart';
import 'package:wobei/page/me/RedPacketPage.dart';
import 'package:wobei/page/me/RightExchangeTicketPage.dart';
import 'package:wobei/page/me/SettingsPage.dart';
import 'package:wobei/page/me/VipExchangeCodePage.dart';

import 'page/ScaffoldPage.dart';

void main() {
  //在调用runApp之前初始化绑定时，需要调用此方法。
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) {
    runApp(MainApp());
  });
}

///*****************************************************************************
///
/// 基层页面
///
///*****************************************************************************
class MainApp extends StatelessWidget {
  //配置路由
  var routes = {
    AppRoute.CARD_TICKET_DETAIL_PAGE:(context) => CardTicketDetailPage(),
    AppRoute.MY_CARD_TICKET_PAGE:(context) => MyCardTicketPage(),
    AppRoute.HE_BEI_SHOP_PAGE: (context) => HeBeiShopPage(),
    AppRoute.MY_PACKET_PAGE: (context) => MyPacketPage(),
    AppRoute.BUY_VIP_PAGE: (context) => BuyVipPagePage(),
    AppRoute.ENTERPRISE_PREFECTURE_PAGE: (context) => EnterprisePrefecturePage(),
    AppRoute.RED_PACKET_PAGE: (context) => RedPacketPage(),
    AppRoute.RIGHT_EXCHANGE_PAGE: (context) => RightExchangeTicketPage(),
    AppRoute.VIP_EXCHANGE_CODE_PAGE: (context) => VipExchangeCodePage(),
    AppRoute.ABOUT: (context) => HeBeiAboutPage(),
    AppRoute.SETTINGS_PAGE: (context) => SettingsPage(),
    AppRoute.NICKNAME_PAGE: (context, {arguments}) => NicknamePage(nickname: arguments,),
    AppRoute.CERTIFICATION_PAGE: (context) => CertificationPage(),
    AppRoute.WEB_PAGE: (context, {arguments}) => WebPage(
          url: arguments,
        ),
    AppRoute.WELCOME_PAGE: (context) => WelcomePage(),
    AppRoute.AD_PAGE: (context, {arguments}) => ADPage(),
    AppRoute.HOME_PAGE: (context) => ScaffoldPage(),
    AppRoute.LOGIN: (context) => LoginPage(),
    // 注意：SearchPage中的arguments如果可选参数，那么这里的arguments必须也是可选参数
    AppRoute.SEARCH_PAGE: (BuildContext context, {List<String> arguments}) =>
        SearchPage(arguments: arguments),
    AppRoute.PERSONAL_INFO: (context, {MeData arguments}) => PersonalInfoPage(
          arguments: arguments,
        ),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '禾权益',
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.white,
          colorScheme: ColorScheme(
            primary: Colors.white,
            primaryVariant: Colors.white,
            secondary: Colors.white,
            secondaryVariant: Colors.white,
            surface: Colors.white,
            background: Colors.white,
            error: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: getFirstPage(),
      color: Colors.white,
      onGenerateRoute: (RouteSettings settings) {
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = AnimationPageRoute(
                animationType: AnimationType.SlideRightToLeft,
                builder: (context) {
                  return pageContentBuilder(context, arguments: settings.arguments);
                });
            return route;
          } else {
            final Route route = AnimationPageRoute(
                animationType: AnimationType.SlideRightToLeft,
                builder: (context){
                  return pageContentBuilder(context);
                });
            return route;
          }
        }
        return null;
      },
    );
  }

  Widget getFirstPage() {
    return ScaffoldPage();
  }
}
