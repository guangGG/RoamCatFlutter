import 'dart:core';

import 'package:dio/dio.dart';

///超时配置
class TimeoutInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 30 * 1000;
    options.sendTimeout = 30 * 1000;
    options.receiveTimeout = 30 * 1000;
    return options;
  }
}
