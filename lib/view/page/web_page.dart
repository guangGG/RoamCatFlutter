import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/util/log_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String url;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _WebPageState(title, url);
  }

  WebPage(this.url, {Key key, this.title});
}

enum WebPopupMenuTag { browser, copyUrl, reload, close }

class _WebPageState extends State<WebPage> {
  static const String tag = "WebPage";
  WebViewController _controller;
  bool _isPageFinish = false;
  String _title;
  String _url;

  _WebPageState(this._title, this._url) {
    if (_url == null || _url.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).urlEmptyTips);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title ?? ""),
        actions: <Widget>[
          PopupMenuButton(
            padding: EdgeInsets.all(0.0),
            onSelected: (tag) {
              if (tag == WebPopupMenuTag.reload) {
                _controller?.reload();
              } else if (tag == WebPopupMenuTag.browser) {
                launch(_url);
              } else if (tag == WebPopupMenuTag.close) {
                Navigator.of(context).pop();
              } else if (tag == WebPopupMenuTag.copyUrl) {
                _controller?.currentUrl()?.then((url) {
                  Clipboard.setData(ClipboardData(text: url));
                  Fluttertoast.showToast(msg: S.of(context).copySuccess);
                });
              }
            },
            itemBuilder: (context) {
              List<PopupMenuEntry<WebPopupMenuTag>> list = [];
              list.add(PopupMenuItem<WebPopupMenuTag>(
                value: WebPopupMenuTag.browser,
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: false,
                  title: Text(S.of(context).openInBrowser),
                ),
              ));
              list.add(PopupMenuItem<WebPopupMenuTag>(
                value: WebPopupMenuTag.copyUrl,
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: false,
                  title: Text(S.of(context).copyUrl),
                ),
              ));
              list.add(PopupMenuItem<WebPopupMenuTag>(
                value: WebPopupMenuTag.reload,
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: false,
                  title: Text(S.of(context).reloadPage),
                ),
              ));
              list.add(PopupMenuItem<WebPopupMenuTag>(
                value: WebPopupMenuTag.close,
                child: ListTile(
                  contentPadding: EdgeInsets.all(0.0),
                  dense: false,
                  title: Text(S.of(context).closePage),
                ),
              ));
              return list;
            },
          )
        ],
      ),
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              _buildWebView(),
              Offstage(
                offstage: _isPageFinish,
                child: Container(
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
          onWillPop: () async {
            //拦截返回键，优先处理WebView的goBack
            var canGoBack = await _controller?.canGoBack();
            if (canGoBack == true) {
              _controller?.goBack();
              return false;
            }
            return true;
          }),
    );
  }

  WebView _buildWebView() {
    return WebView(
      //初始加载url
      initialUrl: _url ?? "",
      //设置允许Javascript
      javascriptMode: JavascriptMode.unrestricted,
      //配置允许直接播放多媒体内容
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
      //开发版本允许调试
      debuggingEnabled: !kReleaseMode,
      //WebView初始化完成回调
      onWebViewCreated: (controller) {
        LogUtil.log("$tag onWebViewCreated");
        _controller = controller;
      },
      //页面开始加载回调
      onPageStarted: (url) {
        LogUtil.log("$tag onPageStarted : ${_logUrlStr(url)}");
        setState(() {
          _url = url;
          _isPageFinish = false;
        });
      },
      //页面加载完成回调
      onPageFinished: (url) {
        LogUtil.log("$tag onPageFinished : ${_logUrlStr(url)}");
        setState(() {
          _url = url;
          _isPageFinish = true;
        });
        Future.wait([
          _controller?.currentUrl(),
          _controller?.canGoBack(),
          _controller?.canGoForward(),
          _controller?.getTitle(),
        ]).then((results) {
          LogUtil.log(
              "$tag title=${results[3]},url=${_logUrlStr(results[0])}, canGoBack=${results[1]},canGoForward=${results[2]}");
          if (results[3] != null && results[3].toString().isNotEmpty) {
            setState(() {
              _title = results[3];
            });
          }
        });
      },
      //定义提供给JS的接口
      javascriptChannels: <JavascriptChannel>[
        _globalJavascriptChannel(context),
      ].toSet(),
    );
  }

  JavascriptChannel _globalJavascriptChannel(BuildContext context) {
    //在JS的window中注入对象，JS通过对象的postMessage方法传递json字符串到onMessageReceived回调；
    //解析JavascriptMessage，根据json内容做相应处理后通过controller.evaluateJavascript返回数据到JS
    return JavascriptChannel(
      name: "RoamcatFlutterJsObj",
      onMessageReceived: (JavascriptMessage message) async {
        try {
          var methodData = json.decode(message.message);
          LogUtil.log(
              "$tag _globalJavascriptChannel msg = ${message.message} \ncall-url:${_logUrlStr(_url)}");
          switch (methodData['method']) {
            case "getAppInfo":
              var packageInfo = await PackageInfo.fromPlatform();
              String data = json.encode({
                "appName": packageInfo.appName,
                "packageName": packageInfo.packageName,
                "version": packageInfo.version,
                "buildNumber": packageInfo.buildNumber,
              });
              _controller?.evaluateJavascript('window.onGetAppInfo($data)');
              break;
          }
        } catch (e) {
          LogUtil.log("$tag _globalJavascriptChannel exception : $e");
        }
      },
    );
  }

  String _logUrlStr(String url) {
    if (url != null) {
      return url.startsWith("http") ? url : "data:text/html";
    }
    return "null";
  }
}
