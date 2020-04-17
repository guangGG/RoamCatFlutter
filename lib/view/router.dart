import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roamcat_flutter/util/log_util.dart';
import 'package:roamcat_flutter/view/page/main_tab_page.dart';
import 'package:roamcat_flutter/view/page/splash_page.dart';
import 'package:roamcat_flutter/view/page/web_page.dart';

class RouteName {
  static const String splash = 'splash';
  static const String mainTab = 'mainTab';
  static const String webPage = 'webPage';
}

//MaterialPageRoute 材料设计样式路由(上下快速滑入滑出)
//CupertinoPageRoute iPhone样式路由(左右快速滑入滑出)
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //settings.name为页面唯一标识，settings.arguments为页面间传参
    LogUtil.log("Router to $settings");
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.mainTab:
        var args = settings.arguments;
        var index = (args is Map) ? args['index'] : 0;
        return CupertinoPageRoute(builder: (_) => MainTabPage(index: index));
      case RouteName.webPage:
        var args = settings.arguments;
        var title = (args is Map) ? args['title'] : null;
        var url = (args is Map) ? args['url'] : null;
        return CupertinoPageRoute(builder: (_) => WebPage(url, title: title));
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

/// 无跳转动画路由
class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) => child);
}
