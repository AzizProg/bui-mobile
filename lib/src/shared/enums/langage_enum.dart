import 'dart:ui';

enum Language {
  english(Locale('en', 'EN'), 'English'),
  french(Locale('fr', 'FR'), 'French');

  final Locale value;
  final String text;
  const Language(this.value, this.text);
}
