import 'dart:async';
import 'dart:ui' as ui;

import 'package:caching/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}

/// We do not use `riverpod_generator` here because it is unable
/// to strongly type `AppLocalizations`
///
final appLocalizationsControllerPod =
    NotifierProvider<AppLocalizationsController, AppLocalizations>(
  () {
    return AppLocalizationsController();
  },
);

class AppLocalizationsController extends Notifier<AppLocalizations> {
  /// Checks if user has saved a preferred language before, if true load user
  /// choice otherwise load system default
  ///
  @override
  AppLocalizations build() {
    final languageCode = ref.watch(utilityCachePod).cachedLanguage;
    if (languageCode != null) {
      state = lookupAppLocalizations(
        Locale(languageCode),
      );
    } else {
      // 1. initialize from the initial locale
      state = lookupAppLocalizations(PlatformDispatcher.instance.locale);
      // 2. create an observer to update the state
      final observer = _LocaleObserver((locales) {
        state = lookupAppLocalizations(PlatformDispatcher.instance.locale);
      });
      // 3. register the observer and dispose it when no longer needed
      final binding = WidgetsBinding.instance;
      binding.addObserver(observer);
      ref.onDispose(() => binding.removeObserver(observer));
      // 4. return the state
    }

    return state;
  }

  /// Sets the locale of choice in memory and then saves it in application
  /// storage by calling [_cache]
  void setLocale(Locale locale) {
    const supportedLocales = AppLocalizations.supportedLocales;

    if (supportedLocales.contains(locale)) {
      state = lookupAppLocalizations(locale);
      _cache(locale);
    }
  }

  void _cache(Locale locale) {
    unawaited(ref.read(utilityCachePod).cacheLanguage(locale: locale));
  }

  /// Helper method to compare other to `state` language name
  ///
  bool isSameLocale(String languageName) => state.localeName == languageName;

  /// Helper method to get the current locale
  /// mainly used in root app
  ///
  Locale get currentLocale => Locale(state.localeName);
}
