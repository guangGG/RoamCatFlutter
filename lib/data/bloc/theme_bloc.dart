import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeEvent {}

class DarkModeThemeEvent extends ThemeEvent {
  bool userDarkMode;

  DarkModeThemeEvent({
    this.userDarkMode = false,
  }) : super();
}

class ColorThemeEvent extends ThemeEvent {
  int themeColorIndex;

  ColorThemeEvent({
    this.themeColorIndex = 0,
  }) : super();
}

class FontThemeEvent extends ThemeEvent {
  int fontIndex;

  FontThemeEvent({
    this.fontIndex = 0,
  }) : super();
}

class DefaultThemeEvent extends ThemeEvent {
  bool userDarkMode;
  int themeColorIndex;
  int fontIndex;

  DefaultThemeEvent({
    this.userDarkMode = false,
    this.themeColorIndex = 0,
    this.fontIndex = 0,
  }) : super();
}

class ThemeState {
  /// 用户选择的明暗模式
  bool userDarkMode;

  /// 当前主题颜色索引
  int themeColorIndex;

  /// 当前字体索引
  int fontIndex;

  ThemeState({
    this.userDarkMode = false,
    this.themeColorIndex = 0,
    this.fontIndex = 0,
  }) : super();
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() {
    _readSpThemeConfig(); //启动时从SharedPreferences读取配置
  }

  @override
  ThemeState get initialState => ThemeState();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is DefaultThemeEvent) {
      yield ThemeState(
          userDarkMode: event.userDarkMode,
          themeColorIndex: event.themeColorIndex,
          fontIndex: event.fontIndex);
    } else if (event is DarkModeThemeEvent) {
      yield ThemeState(
          userDarkMode: event.userDarkMode,
          themeColorIndex: state.themeColorIndex,
          fontIndex: state.fontIndex);
    } else if (event is ColorThemeEvent) {
      yield ThemeState(
          userDarkMode: state.userDarkMode,
          themeColorIndex: event.themeColorIndex,
          fontIndex: state.fontIndex);
    } else if (event is FontThemeEvent) {
      yield ThemeState(
          userDarkMode: state.userDarkMode,
          themeColorIndex: state.themeColorIndex,
          fontIndex: event.fontIndex);
    }
    //保存到runtime内存中
    AppDataHelper.userDarkMode = state.userDarkMode;
    AppDataHelper.themeColorIndex = state.themeColorIndex;
    AppDataHelper.fontIndex = state.fontIndex;
    //样式切换后存储ThemeState到SharedPreferences中
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("userDarkMode", state.userDarkMode);
    sp.setInt("themeColorIndex", state.themeColorIndex);
    sp.setInt("fontIndex", state.fontIndex);
    //黑夜模式切换后更新底部导航栏颜色
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            state.userDarkMode ? Color(0xFF212121) : Color(0xFFFAFAFA),
        systemNavigationBarIconBrightness:
            state.userDarkMode ? Brightness.light : Brightness.dark,
      ));
    }
  }

  //从SharedPreferences中初始化ThemeState
  void _readSpThemeConfig() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      var event = DefaultThemeEvent(
        userDarkMode: sp.getBool("userDarkMode") ?? false,
        themeColorIndex: sp.getInt("themeColorIndex") ?? 0,
        fontIndex: sp.getInt("fontIndex") ?? 0,
      );
      add(event);
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
