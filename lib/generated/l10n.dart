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

  String get exitApp {
    return Intl.message(
      'Exit App',
      name: 'exitApp',
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

  String get pluginSkyStar {
    return Intl.message(
      'Star',
      name: 'pluginSkyStar',
      desc: '',
      args: [],
    );
  }

  String get pluginBookReader {
    return Intl.message(
      'Book',
      name: 'pluginBookReader',
      desc: '',
      args: [],
    );
  }

  String get pluginPoemReader {
    return Intl.message(
      'Poem',
      name: 'pluginPoemReader',
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