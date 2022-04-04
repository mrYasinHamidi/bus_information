import 'package:bus_information/abstracts/Languages.dart';
import 'package:bus_information/langueges/En.dart';
import 'package:bus_information/langueges/Fa.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  static const Iterable<Locale> supportedLocals = [
    Locale('en', ''),
    Locale('fa', ''),
  ];

  @override
  bool isSupported(Locale locale) => ['en', 'fa'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return En();
      case 'fa':
        return Fa();
      default:
        return Fa();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
