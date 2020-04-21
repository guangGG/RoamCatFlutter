import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

///APP中一些常用的工具(部分类库须在pubspec.yaml中导入)
class AppUtil {
  ///获取屏幕尺寸(单位: dp)
  static Size getScreenSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //size.width / size.height
    return size;
  }

  ///获取PackageInfo信息
  static Future<PackageInfo> getPackageInfo() async {
    //packageInfo.appName/packageName/version/buildNumber
    return await PackageInfo.fromPlatform();
  }

  ///获取平台系统类型
  static String getPlatformSystem() {
    return Platform.operatingSystem;
  }

  ///获取当前网络状态
  static Future<ConnectivityResult> checkNetConnectivity() async {
    //监听网络状态： Connectivity().onConnectivityChanged.listen((event) {});
    return Connectivity().checkConnectivity();
  }

  ///判断当前网络是否连接状态
  static Future<bool> isNetConn() async {
    return (await checkNetConnectivity()) != ConnectivityResult.none;
  }

  ///Toast提示
  static Future<bool> toast(String msg) {
    return Fluttertoast.showToast(msg: msg);
  }

  ///获取SharedPreferences实例 (键值对保存在： FlutterSharedPreferences.xml)
  static Future<SharedPreferences> getSharedPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //sp.setString(key, value);
    //sp.get(key);
    return sp;
  }

  ///使用系统应用打开url
  static Future<bool> launchUrl(String url) {
    return launch(url);
  }

  ///申请系统权限
  static Future<bool> requestPermissions(
      List<PermissionGroup> permissions) async {
    Map<PermissionGroup, PermissionStatus> map =
        await PermissionHandler().requestPermissions(permissions);
    bool result = true;
    map.forEach((key, value) {
      if (value != PermissionStatus.granted) {
        result = false;
      }
    });
    return result;
  }

  ///选择手机上的图片或拍摄的照片
  static Future<File> pickImage(ImageSource source) async {
    return ImagePicker.pickImage(source: source);
  }

  ///获取应用目录路径[in Android]
  static Future<Directory> getDir({bool external, bool cache}) async {
    if (Platform.isAndroid) {
      if (external) {
        return cache
            ? getExternalCacheDirectories() //getExternalCacheDir
            : getExternalStorageDirectory(); //getExternalFilesDir(null)
      } else {
        return cache
            ? getTemporaryDirectory() //getCacheDir
            : getApplicationSupportDirectory(); //getFilesDir
      }
    } else {
      return getLibraryDirectory(); //Android throw UnsupportedError
    }
  }
}
