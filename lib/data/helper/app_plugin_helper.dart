import 'package:flutter/material.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/view/router.dart';

class AppPluginHelper {
  static List<AppPlugin> pluginList;

  static List<AppPlugin> getPluginList() {
    if (pluginList == null) {
      List<AppPlugin> list = List();
      list.add(AppPlugin('webview', 'webview', Icons.public, (bool longPress) {
        AppDataHelper.navigatorKey.currentState.pushNamed(
          RouteName.webPage,
          arguments: {'url': 'https://www.baidu.com/'},
        );
      }));
      //demos
      list.add(AppPlugin('tag', 'name', Icons.ac_unit, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.access_alarms, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.account_balance, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.beach_access, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.blur_circular, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.bug_report, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.camera, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.cloud_queue, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.delete_outline, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.directions_bike, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.directions_car, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.cast_connected, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.gamepad, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.local_laundry_service, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.dashboard, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.directions_run, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.edit, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.enhanced_encryption, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.equalizer, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.hourglass_empty, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.contact_phone, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.child_care, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.face, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.favorite, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.filter_frames, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.gavel, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.group, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.group_work, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.local_grocery_store, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.headset, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.home, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.star_half, (tag) {}));
      list.add(AppPlugin('tag', 'name', Icons.import_export, (tag) {}));
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
