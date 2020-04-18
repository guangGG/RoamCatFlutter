import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roamcat_flutter/data/helper/app_plugin_helper.dart';

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
                  Text(_pluginList[index].name,
                      style: TextStyle(color: Theme.of(context).accentColor)),
                ],
              ),
              onTap: () {
                _pluginList[index].onPress(false);
              },
              onLongPress: () {
                _pluginList[index].onPress(true);
              },
            );
          }),
    );
  }
}
