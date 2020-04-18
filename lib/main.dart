import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roamcat_flutter/data/bloc/locale_bloc.dart';
import 'package:roamcat_flutter/data/bloc/theme_bloc.dart';
import 'package:roamcat_flutter/data/helper/app_constants.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/view/router.dart';

//应用flutter代码main方法-入口函数
void main() async {
  //安卓上设置透明状态栏
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  //启动应用界面
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
      ),
      BlocProvider<LocaleBloc>(
        create: (BuildContext context) => LocaleBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return _buildMaterialApp(context, themeState, localeState);
          },
        );
      },
    );
  }

  MaterialApp _buildMaterialApp(
      BuildContext context, ThemeState themeState, LocaleState localeState) {
    return MaterialApp(
      // title: 安卓上为应用任务名(任务视图时应用显示的名称)，iOS上未使用
      // App域下的context不能用于国际化工具类S.of(context)
      title: 'RoamCatF',
      // 设置应用主题
      theme: _buildThemeData(themeState),
      darkTheme: _buildThemeData(themeState, platformDarkMode: true),
      // 设置应用locale(null表示跟随系统)
      locale: localeState.getLocale(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        RefreshLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      navigatorKey: AppDataHelper.navigatorKey,
      onGenerateRoute: Router.generateRoute,
      initialRoute: RouteName.splash,
    );
  }

  //设置应用主题(使用动态ThemeState配置)
  ThemeData _buildThemeData(ThemeState themeState,
      {bool platformDarkMode: false}) {
    var isDark = platformDarkMode || themeState.userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    MaterialColor themeColor =
        AppConstants.colorValueList[themeState.themeColorIndex];
    var accentColor = isDark ? themeColor[700] : themeColor;
    var themeData = ThemeData(
      brightness: brightness,
      primarySwatch: themeColor,
      accentColor: accentColor,
      fontFamily: AppConstants.fontValueList[themeState.fontIndex],
    );
    return themeData;
  }
}
