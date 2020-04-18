import 'package:flutter/services.dart';

class AppMethodChannel {
  static MethodChannel methodChannel =
      MethodChannel("gapp.season.roamcat_flutter:MethodChannel");

  static void openSkyStar() {
    methodChannel.invokeMethod("SkyStar");
  }

  static void openBookReader() {
    methodChannel.invokeMethod("BookReader");
  }

  static void openPoemReader() {
    methodChannel.invokeMethod("PoemReader");
  }
}
