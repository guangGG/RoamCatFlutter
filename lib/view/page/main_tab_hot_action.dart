import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/util/isolate_util.dart';
import 'package:roamcat_flutter/view/dialog/progress_dialog.dart';
import 'package:roamcat_flutter/view/router.dart';

class MainTabHotAction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainTabHotActionState();
  }
}

class _MainTabHotActionState extends State<MainTabHotAction>
    with AutomaticKeepAliveClientMixin {
  //由于PageView切换页面不能保持状态，需要保持状态的子Page需要通过混入AutomaticKeepAliveClientMixin解决状态问题
  @override
  bool get wantKeepAlive => true;

  String _showInfo = "";

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //AutomaticKeepAliveClientMixin状态存储
    return Scaffold(
      body: Column(children: <Widget>[
        //可使用 Wrap 控件实现安卓中FlexBoxLayout效果
        Container(
          height: 30,
          color: Color(0x12000000),
          child: Row(children: <Widget>[
            Container(width: 10),
            Expanded(child: Text(S.of(context).showInfo)),
            InkWell(
              child: Text(
                S.of(context).clipboard,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.clipboardPage);
              },
            ),
            Container(width: 10),
            InkWell(
              child: Text(
                S.of(context).copy,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: _showInfo));
                Fluttertoast.showToast(msg: S.of(context).copySuccess);
              },
            ),
            Container(width: 10),
            InkWell(
              child: Text(
                S.of(context).paste,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onTap: () async {
                _showInfo = (await Clipboard.getData('text/plain')).text;
                setState(() {});
              },
            ),
            Container(width: 10),
          ]),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            child: ListView(children: <Widget>[SelectableText(_showInfo)]),
          ),
        ),
      ]),
      floatingActionButton: SpeedDial(
        //菜单展开时的Icon
        animatedIcon: AnimatedIcons.menu_close,
        //弹窗背景阴影配置
        overlayColor: Colors.black,
        overlayOpacity: 0.2,
        children: [
          SpeedDialChild(
            child: Icon(Icons.devices),
            label: S.of(context).deviceInfo,
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            onTap: () {
              _getDeviceInfo();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.timelapse),
            label: S.of(context).dealOpt,
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            onTap: () {
              _dealOpt();
            },
          ),
        ],
      ),
    );
  }

  void _getDeviceInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    _showInfo = "operatingSystem: ${Platform.operatingSystem}\n" +
        "numberOfProcessors: ${Platform.numberOfProcessors}\n" +
        "localeName: ${Platform.localeName}\n" +
        "operatingSystemVersion: ${Platform.operatingSystemVersion}\n" +
        "localHostname: ${Platform.localHostname}\n" +
        "appName: ${packageInfo.appName}\n" +
        "packageName: ${packageInfo.packageName}\n" +
        "version: ${packageInfo.version}\n" +
        "buildNumber: ${packageInfo.buildNumber}\n";
    setState(() {});
  }

  //todo io线程处理耗时操作示例
  void _dealOpt() async {
    int num1 = 20;
    int num2 = 123456789;
    //在io线程处理耗时操作
    var future1 = IsolateUtil.computeFun(_factorial, num1);
    var future2 = IsolateUtil.computeFun(_cumulative, num2);
    //合并执行多个异步操作
    ProgressDialog.show(context, msg: S.of(context).loading);
    var result = await Future.wait([future1, future2]);
    ProgressDialog.dismiss();
    int value1 = result[0];
    int value2 = result[1];
    _showInfo =
        "factorial($num1) = $value1\n" + "cumulative($num2) = $value2\n";
    setState(() {});
  }

  //阶乘(num大于20会超出int正整数范围)
  static int _factorial(num) {
    int result = 1;
    for (var i = 1; i <= num; i++) {
      result = result * i;
    }
    return result;
  }

  //累加
  static int _cumulative(num) {
    int result = 0;
    for (var i = 1; i <= num; i++) {
      result = result + i;
    }
    return result;
  }
}
