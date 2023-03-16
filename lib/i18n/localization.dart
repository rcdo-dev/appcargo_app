import 'dart:ui';

import 'package:app_cargo/i18n/translations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalization implements Translations {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static Map<String, Translations> _localizedValues = {
    'en': EnglishTranslations(),
    'pt': PortugueseTranslations(),
  };

  // From here on, a delegate would be WONDERFUL
  // If you are enraged by the redundancy, take a look here and help:
  // https://github.com/a14n/zengen/issues/29

  String get appName => _localizedValues[this.locale.languageCode].appName;
  String get language => _localizedValues[this.locale.languageCode].language;

  String get alertNewAccount => _localizedValues[this.locale.languageCode].alertNewAccount;
  String get alertNewAccountDescription  => _localizedValues[this.locale.languageCode].alertNewAccountDescription;

  String get actionWannaSignUp => _localizedValues[this.locale.languageCode].actionWannaSignUp;
  String get actionMaybeLater => _localizedValues[this.locale.languageCode].actionMaybeLater;
}

// https://github.com/flutter/website/blob/master/examples/internationalization/minimal/lib/main.dart
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) =>
      SynchronousFuture<AppLocalization>(AppLocalization(locale));

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}