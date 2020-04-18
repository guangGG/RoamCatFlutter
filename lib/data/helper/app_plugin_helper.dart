import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roamcat_flutter/data/channel/app_method_channel.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/util/extra_types.dart';
import 'package:roamcat_flutter/view/router.dart';

class AppPluginHelper {
  static const String tagSkyStar = "SkyStar";
  static const String tagBookReader = "BookReader";
  static const String tagPoemReader = "PoemReader";
  static const String tagBrowser = "browser";

  static List<AppPlugin> pluginList;

  static List<AppPlugin> getPluginList() {
    if (pluginList == null) {
      //var context = AppDataHelper.navigatorKey.currentState.context;
      List<AppPlugin> list = List();
      if (Platform.isAndroid) {
        //使用MethodChannel调用Android原生方法
        list.add(AppPlugin(
          tagSkyStar,
          (context) {
            return S.of(context).pluginSkyStar;
          },
          Icons.brightness_2,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openSkyStar();
            }
          },
          permissions: [PermissionGroup.locationWhenInUse],
        ));
        list.add(AppPlugin(
          tagBookReader,
          (context) {
            return S.of(context).pluginBookReader;
          },
          Icons.book,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openBookReader();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagPoemReader,
          (context) {
            return S.of(context).pluginPoemReader;
          },
          Icons.cloud_queue,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openPoemReader();
            }
          },
        ));
      }
      list.add(AppPlugin(
        tagBrowser,
        (context) {
          return S.of(context).pluginBrowser;
        },
        Icons.public,
        (bool longPress) async {
          if (!longPress) {
            String content =
                await rootBundle.loadString("assets/files/web_home.html");
            String url = Uri.dataFromString(content,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString();
            AppDataHelper.navigatorKey.currentState.pushNamed(
              RouteName.webPage,
              arguments: {'url': url},
            );
          }
        },
      ));
      // todo demos
      list.add(AppPlugin('tag', _demoName, Icons.ac_unit, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.access_alarms, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.account_balance, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.beach_access, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.blur_circular, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.bug_report, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.camera, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.camera_roll, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.delete_outline, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.directions_bike, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.directions_car, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.cast_connected, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.gamepad, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.device_hub, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.dashboard, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.directions_run, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.edit, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.explore, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.equalizer, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.hourglass_empty, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.contact_phone, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.child_care, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.face, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.favorite, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.filter_frames, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.gavel, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.group, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.group_work, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.grade, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.headset, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.home, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.star_half, _demoPress));
      list.add(AppPlugin('tag', _demoName, Icons.import_export, _demoPress));
      pluginList = list;
    }
    return pluginList;
  }

  static String _demoName(BuildContext context) {
    return 'Plugin';
  }

  static void _demoPress(bool longPress) {
    if (!longPress) Fluttertoast.showToast(msg: "coming soon");
  }
}

//通过方法动态获取插件名称，防止语言切换无效
class AppPlugin {
  String tag;
  ValueSetterGetter<String, BuildContext> name;
  IconData icon;
  ValueSetter<bool> onPress;
  List<PermissionGroup> permissions;

  AppPlugin(this.tag, this.name, this.icon, this.onPress, {this.permissions});
}
