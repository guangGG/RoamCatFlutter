import 'package:flutter/material.dart';
import 'package:roamcat_flutter/data/helper/app_constants.dart';
import 'package:roamcat_flutter/generated/l10n.dart';

class AppDataHelper {
  static int localeValueIndex = 0;
  static bool userDarkMode = false;
  static int themeColorIndex = 0;
  static int fontIndex = 0;

  //维护全局NavigatorContext
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  //标记DoraemonKit浮标是否显示
  static bool showDebugIcon = false;

  static int nextIndex(List list, int currentIndex) {
    if (currentIndex + 1 >= list.length) {
      return 0;
    } else {
      return currentIndex + 1;
    }
  }

  static String getFontName(BuildContext context, int fontIndex) {
    if (fontIndex == 1) {
      return S.of(context).fontHappy;
    } else {
      return S.of(context).fontDefault;
    }
  }

  static String getLanguageName(BuildContext context, String locale) {
    if (locale == AppConstants.localeValueList[1]) {
      return S.of(context).languageZh;
    } else if (locale == AppConstants.localeValueList[2]) {
      return S.of(context).languageEn;
    } else {
      return S.of(context).languageNone;
    }
  }
}
