import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color get primary => const Color(0xFF284485);
  static Color get secondary => const Color(0x0ff19e39);
  static Color get ternary => const Color(0xFF284bc1);
  static Color get background => const Color(0xFFEAEFF2);
  static Color get black => const Color(0xFF1F1F1F);
  static Gradient get gradientColor => LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [primary, ternary],);
}
