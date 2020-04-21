import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/util/app_util.dart';
import 'package:roamcat_flutter/view/router.dart';
import 'package:roamcat_flutter/view/widget/no_ripple_scroll_behavior.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  var _versionName;
  var _versionCode;

  @override
  void initState() {
    super.initState();
    AppUtil.getPackageInfo().then((PackageInfo packageInfo) {
      setState(() {
        _versionName = packageInfo.version;
        _versionCode = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutUs),
      ),
      body: buildNoRippleScrollWidget(ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 50),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    "assets/images/icon_logo.png",
                    width: 150,
                    height: 150,
                  ),
                  Container(height: 10),
                  Text(
                    S.of(context).appName,
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(height: 10),
                  Text(
                    S.of(context).versionShow(_versionName, _versionCode),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 0.2, color: Theme.of(context).dividerColor),
          ListTile(
            title: Text(S.of(context).appRoamCatX),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteName.webPage,
                arguments: {'url': 'https://github.com/guangGG/RoamCatX'},
              );
            },
          ),
          Container(height: 0.2, color: Theme.of(context).dividerColor),
          ListTile(
            title: Text(S.of(context).sourceCode),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteName.webPage,
                arguments: {'url': 'https://github.com/guangGG/RoamCatFlutter'},
              );
            },
          ),
          Container(height: 0.2, color: Theme.of(context).dividerColor),
        ],
      )),
    );
  }
}
