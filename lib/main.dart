import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roamcat_flutter/view/router.dart';

//应用flutter代码main方法-入口函数
void main() async {
  //安卓上设置透明状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  //启动应用界面
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildMaterialApp(context);
  }

  MaterialApp _buildMaterialApp(BuildContext context) {
    return MaterialApp(
      // title: 安卓上为应用任务名(任务视图时应用显示的名称)，iOS上未使用
      // App域下的context不能用于国际化工具类S.of(context)
      title: 'RoamCatFlutter',
      // 设置应用主题
      theme: _buildThemeData(),
      darkTheme: _buildThemeData(platformDarkMode: true),
      // 设置应用locale(null表示跟随系统)
      locale: null,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        RefreshLocalizations.delegate,
      ],
      onGenerateRoute: Router.generateRoute,
      initialRoute: RouteName.splash,
    );
  }

  //设置应用主题(使用动态ThemeState配置)
  ThemeData _buildThemeData({bool platformDarkMode: false}) {
    var isDark = platformDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    var themeColor = Colors.blue;
    var accentColor = isDark ? themeColor[700] : themeColor;
    const fontValueList = ['system', 'happyfont']; //支持的字体样式列表
    var themeData = ThemeData(
      brightness: brightness,
      primarySwatch: themeColor,
      accentColor: accentColor,
      fontFamily: fontValueList[1],
    );
    return themeData;
  }
}
