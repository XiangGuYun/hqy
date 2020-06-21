import 'package:flutter/material.dart';
import 'package:wobei/common/Global.dart';
import 'package:wobei/constant/AppRoute.dart';
import 'package:wobei/page/intro/ADPage.dart';
import 'package:wobei/page/intro/WelcomePage.dart';
import 'package:wobei/page/login/LoginPage.dart';
import 'package:wobei/test.dart';

import 'page/ScaffoldPage.dart';

void main() {
  //在调用runApp之前初始化绑定时，需要调用此方法。
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e){
    runApp(TestApp());
  });
}

class MainApp extends StatelessWidget {
  var routes = {
    //配置路由
    AppRoute.WELCOME_PAGE: (context) => WelcomePage(),
    AppRoute.AD_PAGE: (context, {arguments}) => ADPage(
          arguments: arguments,
        ),
    AppRoute.HOME_PAGE: (context) => ScaffoldPage(),
    AppRoute.LOGIN: (context) => LoginPage(),
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
      },
    );
  }

  Widget getFirstPage() {
    return WelcomePage();
  }
}
