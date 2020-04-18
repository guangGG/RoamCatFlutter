import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/view/router.dart';

class AppPluginHelper {
  static const String tagBrowser = "browser";

  static List<AppPlugin> pluginList;

  static List<AppPlugin> getPluginList() {
    if (pluginList == null) {
      var context = AppDataHelper.navigatorKey.currentState.context;
      List<AppPlugin> list = List();
      list.add(AppPlugin(tagBrowser, S.of(context).pluginBrowser, Icons.public,
          (bool longPress) async {
        if (!longPress) {
          String content =
              await rootBundle.loadString("assets/files/web_home.html");
          String url = Uri.dataFromString(content,
                  mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
              .toString();
          AppDataHelper.navigatorKey.currentState.pushNamed(
            RouteName.webPage,
            arguments: {'url': url},
          );
        }
      }));
      //demos
      list.add(AppPlugin('tag', 'Plugin', Icons.ac_unit, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.access_alarms, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.account_balance, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.beach_access, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.blur_circular, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.bug_report, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.camera, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.cloud_queue, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.delete_outline, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.directions_bike, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.directions_car, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.cast_connected, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.gamepad, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.device_hub, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.dashboard, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.directions_run, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.edit, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.explore, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.equalizer, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.hourglass_empty, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.contact_phone, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.child_care, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.face, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.favorite, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.filter_frames, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.gavel, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.group, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.group_work, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.grade, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.headset, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.home, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.star_half, (tag) {}));
      list.add(AppPlugin('tag', 'Plugin', Icons.import_export, (tag) {}));
      pluginList = list;
    }
    return pluginList;
  }
}

class AppPlugin {
  String tag;
  String name;
  IconData icon;
  ValueChanged<bool> onPress;

  AppPlugin(this.tag, this.name, this.icon, this.onPress);
}
