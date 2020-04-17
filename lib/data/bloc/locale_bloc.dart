import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roamcat_flutter/data/helper/app_constants.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocaleEvent {}

class DefaultLocaleEvent extends LocaleEvent {
  int localeValueIndex;

  DefaultLocaleEvent({
    this.localeValueIndex = 0,
  }) : super();
}

class LocaleState {
  String localeValue;

  LocaleState({
    this.localeValue,
  }) : super();

  Locale getLocale() {
    //['', 'zh-CN', 'en']
    if (localeValue != null && localeValue.isNotEmpty) {
      var value = localeValue.split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    return null; //Locale为null表示跟随系统
  }
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() {
    _readSpLocaleConfig(); //启动时从SharedPreferences读取配置
  }

  @override
  LocaleState get initialState => LocaleState();

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    if (event is DefaultLocaleEvent) {
      yield LocaleState(
          localeValue: AppConstants.localeValueList[event.localeValueIndex]);
      //保存到runtime内存中
      AppDataHelper.localeValueIndex = event.localeValueIndex;
      //语言切换后存储LocaleState到SharedPreferences中
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setInt("localeValueIndex", event.localeValueIndex);
    }
  }

  //从SharedPreferences中初始化LocaleState
  void _readSpLocaleConfig() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      var event = DefaultLocaleEvent(
          localeValueIndex: sp.getInt("localeValueIndex") ?? 0);
      add(event);
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
