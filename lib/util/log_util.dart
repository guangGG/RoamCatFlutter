import 'dart:io';

import 'package:flutter/foundation.dart';

class LogUtil {
  ///调试时打印的日志，发布包不打印日志
  static void log(msg) {
    if (!kReleaseMode) {
      print("[${Platform.operatingSystem}] $msg");
    }
  }
}
