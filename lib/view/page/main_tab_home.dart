import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:roamcat_flutter/data/helper/app_plugin_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';

class MainTabHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainTabHomeState();
  }
}

class _MainTabHomeState extends State<MainTabHome> {
  List<AppPlugin> _pluginList;

  _MainTabHomeState();

  @override
  void initState() {
    super.initState();
    _pluginList = AppPluginHelper.getPluginList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          padding: EdgeInsets.all(5),
          itemCount: _pluginList?.length ?? 0,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(_pluginList[index].icon,
                      size: 30, color: Theme.of(context).accentColor),
                  Container(height: 5),
                  Text(_pluginList[index].name(context),
                      style: TextStyle(color: Theme.of(context).accentColor)),
                ],
              ),
              onTap: () async {
                if (await requestPermissions(_pluginList[index].permissions)) {
                  _pluginList[index].onPress(false);
                } else {
                  Fluttertoast.showToast(msg: S.of(context).noPermissionTips);
                }
              },
              onLongPress: () async {
                if (await requestPermissions(_pluginList[index].permissions)) {
                  _pluginList[index].onPress(true);
                } else {
                  Fluttertoast.showToast(msg: S.of(context).noPermissionTips);
                }
              },
            );
          }),
    );
  }

  Future<bool> requestPermissions(List<PermissionGroup> permissions) async {
    if (permissions == null || permissions.isEmpty) {
      return true;
    } else {
      Map<PermissionGroup, PermissionStatus> map =
          await PermissionHandler().requestPermissions(permissions);
      bool pass = true;
      map.forEach((key, value) {
        if (value != PermissionStatus.granted) {
          pass = false;
        }
      });
      return pass;
    }
  }
}
