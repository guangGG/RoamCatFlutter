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

  static void openWebBrowser() {
    methodChannel.invokeMethod("WebBrowser");
  }

  static void openApplications() {
    methodChannel.invokeMethod("Applications");
  }

  static void openNote() {
    methodChannel.invokeMethod("Note");
  }

  static void openPrivateNote() {
    methodChannel.invokeMethod("PrivateNote");
  }

  static void openFileManager() {
    methodChannel.invokeMethod("FileManager");
  }

  static void openMusicPlayer() {
    methodChannel.invokeMethod("MusicPlayer");
  }

  static void openGallery() {
    methodChannel.invokeMethod("Gallery");
  }

  static void openVideo() {
    methodChannel.invokeMethod("Video");
  }

  static void openTextViewer() {
    methodChannel.invokeMethod("TextViewer");
  }

  static void openImageViewer() {
    methodChannel.invokeMethod("ImageViewer");
  }

  static void openFileClear() {
    methodChannel.invokeMethod("FileClear");
  }

  static void openCalendar() {
    methodChannel.invokeMethod("Calendar");
  }

  static void openCalculator() {
    methodChannel.invokeMethod("Calculator");
  }

  static void openNerveRabbit() {
    methodChannel.invokeMethod("NerveRabbit");
  }

  static void openSudoku() {
    methodChannel.invokeMethod("Sudoku");
  }

  static void openDrawingBoard() {
    methodChannel.invokeMethod("DrawingBoard");
  }

  static void openScanQrCode() {
    methodChannel.invokeMethod("ScanQrCode");
  }

  static void openVideoPlayer() {
    methodChannel.invokeMethod("VideoPlayer");
  }

  static void openFileSelector() {
    methodChannel.invokeMethod("FileSelector");
  }

  static void openMusicList() {
    methodChannel.invokeMethod("MusicList");
  }

  static void switchDoraemonKit(bool show) {
    methodChannel.invokeMethod("DoraemonKit", show);
  }
}
