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