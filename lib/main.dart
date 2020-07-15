import 'package:flutter/material.dart';
import 'package:wobei/bean/MeData.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/page/WebPage.dart';
import 'package:wobei/page/home/SearchPage.dart';
import 'package:wobei/page/intro/ADPage.dart';
import 'package:wobei/page/intro/WelcomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/page/me/CertificationPage.dart';
import 'package:wobei/page/me/PersonalInfoPage.dart';

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
    AppRoute.CERTIFICATION_PAGE:(context) => CertificationPage(),
    AppRoute.WEB_PAGE: (context, {arguments}) => WebPage(url: arguments,),
    AppRoute.WELCOME_PAGE: (context) => WelcomePage(),
    AppRoute.AD_PAGE: (context, {arguments}) => ADPage(),
    AppRoute.HOME_PAGE: (context) => ScaffoldPage(),
    AppRoute.LOGIN: (context) => LoginPage(),
    // 注意：SearchPage中的arguments如果可选参数，那么这里的arguments必须也是可选参数
    AppRoute.SEARCH_PAGE: (BuildContext context, {List<String> arguments}) =>
        SearchPage(arguments: arguments),
    AppRoute.PERSONAL_INFO: (context, {MeData arguments}) => PersonalInfoPage(arguments: arguments,),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '禾权益',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: getFirstPage(),
      onGenerateRoute: (RouteSettings settings) {
        final String name = settings.name;
        final Function pageContentBuilder = this.routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
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
