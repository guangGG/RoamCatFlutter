// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appName {
    return Intl.message(
      'RoamCatF',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  String get splashText {
    return Intl.message(
      'RoamCatF',
      name: 'splashText',
      desc: '',
      args: [],
    );
  }

  String get mainPageTitle {
    return Intl.message(
      'RoamCatF',
      name: 'mainPageTitle',
      desc: '',
      args: [],
    );
  }

  String get mainPageName {
    return Intl.message(
      'Home',
      name: 'mainPageName',
      desc: '',
      args: [],
    );
  }

  String get hotTabTitle {
    return Intl.message(
      'HotAction',
      name: 'hotTabTitle',
      desc: '',
      args: [],
    );
  }

  String get hotTabName {
    return Intl.message(
      'HotAction',
      name: 'hotTabName',
      desc: '',
      args: [],
    );
  }

  String get reClickExit {
    return Intl.message(
      'Click again to exit the application',
      name: 'reClickExit',
      desc: '',
      args: [],
    );
  }

  String get urlEmptyTips {
    return Intl.message(
      'Url cannot be empty',
      name: 'urlEmptyTips',
      desc: '',
      args: [],
    );
  }

  String get openInBrowser {
    return Intl.message(
      'Open In Browser',
      name: 'openInBrowser',
      desc: '',
      args: [],
    );
  }

  String get reloadPage {
    return Intl.message(
      'Reload Page',
      name: 'reloadPage',
      desc: '',
      args: [],
    );
  }

  String get closePage {
    return Intl.message(
      'Close Page',
      name: 'closePage',
      desc: '',
      args: [],
    );
  }

  String get drawerMsg {
    return Intl.message(
      'Life is like a river, running forward continuously. The two sides of the river have four different views. On the one hand, we should overcome the resistance and move forward; on the other hand, we should not forget that all kinds of scenery on both sides of the Straits are worth our appreciation and taste.',
      name: 'drawerMsg',
      desc: '',
      args: [],
    );
  }

  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  String versionShow(Object name, Object code) {
    return Intl.message(
      'Version:$name($code)',
      name: 'versionShow',
      desc: '',
      args: [name, code],
    );
  }

  String get sourceCode {
    return Intl.message(
      'Source code',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  String get appRoamCatX {
    return Intl.message(
      'RoamCatX APP',
      name: 'appRoamCatX',
      desc: '',
      args: [],
    );
  }

  String get blackTheme {
    return Intl.message(
      'Dark mode',
      name: 'blackTheme',
      desc: '',
      args: [],
    );
  }

  String get switchThemeColor {
    return Intl.message(
      'Theme color',
      name: 'switchThemeColor',
      desc: '',
      args: [],
    );
  }

  String get switchFont {
    return Intl.message(
      'Text Font',
      name: 'switchFont',
      desc: '',
      args: [],
    );
  }

  String get fontDefault {
    return Intl.message(
      'Default',
      name: 'fontDefault',
      desc: '',
      args: [],
    );
  }

  String get fontHappy {
    return Intl.message(
      'Happy',
      name: 'fontHappy',
      desc: '',
      args: [],
    );
  }

  String get switchLanguage {
    return Intl.message(
      'Language',
      name: 'switchLanguage',
      desc: '',
      args: [],
    );
  }

  String get languageNone {
    return Intl.message(
      'System',
      name: 'languageNone',
      desc: '',
      args: [],
    );
  }

  String get languageZh {
    return Intl.message(
      '简体中文',
      name: 'languageZh',
      desc: '',
      args: [],
    );
  }

  String get languageEn {
    return Intl.message(
      'English',
      name: 'languageEn',
      desc: '',
      args: [],
    );
  }

  String get showInfo {
    return Intl.message(
      'Info',
      name: 'showInfo',
      desc: '',
      args: [],
    );
  }

  String get clipboard {
    return Intl.message(
      'Clipboard',
      name: 'clipboard',
      desc: '',
      args: [],
    );
  }

  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  String get paste {
    return Intl.message(
      'Paste',
      name: 'paste',
      desc: '',
      args: [],
    );
  }

  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  String get loading {
    return Intl.message(
      'loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  String get deviceInfo {
    return Intl.message(
      'DeviceInfo',
      name: 'deviceInfo',
      desc: '',
      args: [],
    );
  }

  String get dealOpt {
    return Intl.message(
      'DealOption',
      name: 'dealOpt',
      desc: '',
      args: [],
    );
  }

  String get exitApp {
    return Intl.message(
      'Exit App',
      name: 'exitApp',
      desc: '',
      args: [],
    );
  }

  String get noPermissionTips {
    return Intl.message(
      'This feature requires permission to be granted before it can be used',
      name: 'noPermissionTips',
      desc: '',
      args: [],
    );
  }

  String get copyUrl {
    return Intl.message(
      'Copy page url',
      name: 'copyUrl',
      desc: '',
      args: [],
    );
  }

  String get copySuccess {
    return Intl.message(
      'Copy success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  String get pluginTag {
    return Intl.message(
      'Plugin',
      name: 'pluginTag',
      desc: '',
      args: [],
    );
  }

  String get pluginBrowser {
    return Intl.message(
      'Browser',
      name: 'pluginBrowser',
      desc: '',
      args: [],
    );
  }

  String get android_item_skystar {
    return Intl.message(
      'Sky',
      name: 'android_item_skystar',
      desc: '',
      args: [],
    );
  }

  String get android_item_reader {
    return Intl.message(
      'Reader',
      name: 'android_item_reader',
      desc: '',
      args: [],
    );
  }

  String get android_item_poem {
    return Intl.message(
      'Poem',
      name: 'android_item_poem',
      desc: '',
      args: [],
    );
  }

  String get android_item_webbrowser {
    return Intl.message(
      'WebBrowser',
      name: 'android_item_webbrowser',
      desc: '',
      args: [],
    );
  }

  String get android_item_apps {
    return Intl.message(
      'Applications',
      name: 'android_item_apps',
      desc: '',
      args: [],
    );
  }

  String get android_item_note {
    return Intl.message(
      'Note',
      name: 'android_item_note',
      desc: '',
      args: [],
    );
  }

  String get android_item_private_note {
    return Intl.message(
      'PrivateNotes',
      name: 'android_item_private_note',
      desc: '',
      args: [],
    );
  }

  String get android_item_file_manager {
    return Intl.message(
      'FileManager',
      name: 'android_item_file_manager',
      desc: '',
      args: [],
    );
  }

  String get android_item_music {
    return Intl.message(
      'MusicPlayer',
      name: 'android_item_music',
      desc: '',
      args: [],
    );
  }

  String get android_item_gallery {
    return Intl.message(
      'Gallery',
      name: 'android_item_gallery',
      desc: '',
      args: [],
    );
  }

  String get android_item_videos {
    return Intl.message(
      'Videos',
      name: 'android_item_videos',
      desc: '',
      args: [],
    );
  }

  String get android_item_text_viewer {
    return Intl.message(
      'TextViewer',
      name: 'android_item_text_viewer',
      desc: '',
      args: [],
    );
  }

  String get android_item_image_viewer {
    return Intl.message(
      'ImageViewer',
      name: 'android_item_image_viewer',
      desc: '',
      args: [],
    );
  }

  String get android_item_file_clear {
    return Intl.message(
      'FileCleaner',
      name: 'android_item_file_clear',
      desc: '',
      args: [],
    );
  }

  String get android_item_sport_list {
    return Intl.message(
      'SportRecord',
      name: 'android_item_sport_list',
      desc: '',
      args: [],
    );
  }

  String get android_item_calendar {
    return Intl.message(
      'Calendar',
      name: 'android_item_calendar',
      desc: '',
      args: [],
    );
  }

  String get android_item_calculator {
    return Intl.message(
      'Calculator',
      name: 'android_item_calculator',
      desc: '',
      args: [],
    );
  }

  String get android_item_clipboard {
    return Intl.message(
      'Clipboard',
      name: 'android_item_clipboard',
      desc: '',
      args: [],
    );
  }

  String get android_item_nerve_rabbit {
    return Intl.message(
      'NerveRabbit',
      name: 'android_item_nerve_rabbit',
      desc: '',
      args: [],
    );
  }

  String get android_item_sudoku {
    return Intl.message(
      'Sudoku',
      name: 'android_item_sudoku',
      desc: '',
      args: [],
    );
  }

  String get android_item_drawboard {
    return Intl.message(
      'DrawingBoard',
      name: 'android_item_drawboard',
      desc: '',
      args: [],
    );
  }

  String get android_item_scan {
    return Intl.message(
      'ScanCode',
      name: 'android_item_scan',
      desc: '',
      args: [],
    );
  }

  String get android_item_video_player {
    return Intl.message(
      'VideoPlayer',
      name: 'android_item_video_player',
      desc: '',
      args: [],
    );
  }

  String get android_item_file_selector {
    return Intl.message(
      'FileSelector',
      name: 'android_item_file_selector',
      desc: '',
      args: [],
    );
  }

  String get android_item_music_list {
    return Intl.message(
      'MusicStore',
      name: 'android_item_music_list',
      desc: '',
      args: [],
    );
  }

  String get android_item_doraemon_kit {
    return Intl.message(
      'Doraemon',
      name: 'android_item_doraemon_kit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'), Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}