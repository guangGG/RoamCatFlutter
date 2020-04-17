import 'package:dio/dio.dart';
import 'package:roamcat_flutter/data/net/interceptor/timeout_interceptor.dart';

final ApiHelper appApiHelper = new ApiHelper();

class ApiHelper {
  final Dio _dio = new Dio();

  ApiHelper() {
    //设置通用拦截器
    _dio.interceptors.add(TimeoutInterceptor());
    _dio.interceptors.add(LogInterceptor());
  }

  Dio get dio => _dio;
}
