import 'package:caching/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group(UtilityCache, () {
    test(ThemeMode.system, () async {
      SharedPreferences.setMockInitialValues({});

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final UtilityCache utilityCache =
          UtilityCache(sharedPreferences: sharedPreferences);
      final result = utilityCache.isDarkModeEnabled;
      expect(result, false);
    });
    test(ThemeMode.dark, () async {
      SharedPreferences.setMockInitialValues({Cachable.theme.name: true});

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final UtilityCache utilityCache =
          UtilityCache(sharedPreferences: sharedPreferences);
      final result = utilityCache.isDarkModeEnabled;
      expect(result, true);
    });
    test(ThemeMode.light, () async {
      SharedPreferences.setMockInitialValues({Cachable.theme.name: false});

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final UtilityCache utilityCache =
          UtilityCache(sharedPreferences: sharedPreferences);
      final result = utilityCache.isDarkModeEnabled;
      expect(result, false);
    });
    test('Locale is default', () async {
      SharedPreferences.setMockInitialValues({});

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final UtilityCache utilityCache =
          UtilityCache(sharedPreferences: sharedPreferences);
      final result = utilityCache.cachedLanguage;
      expect(result, null);
    });
    test('Locale is preferred', () async {
      SharedPreferences.setMockInitialValues({Cachable.locale.name: 'en'});

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final UtilityCache utilityCache =
          UtilityCache(sharedPreferences: sharedPreferences);
      final result = utilityCache.cachedLanguage;
      expect(result, 'en');
    });
  });
}
