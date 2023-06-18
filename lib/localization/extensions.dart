import 'dart:ui';

extension LocaleX on Locale {
  String get flagCode {
    switch (languageCode) {
      case 'ar':
        return 'SA';
      case 'en':
        return 'GB';
      case 'es':
        return 'ES';
      case 'ko':
        return 'KR';
      default:
        throw UnimplementedError('$languageCode is not supported yet');
    }
  }

  String get uiString {
    switch (languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'ko':
        return '한국인';
      default:
        throw UnimplementedError('$languageCode is not supported yet');
    }
  }
}
