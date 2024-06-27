import 'package:flutter/material.dart';
import 'package:test_mobile/src/shared/constants/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme => ThemeData.light().copyWith(
      textTheme: _textStyle,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primary,
  );
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
      textTheme: _textStyle,
      primaryColor: AppColors.primary,);

  static TextTheme get _textStyle => TextTheme(
        titleMedium: TextStyle(
          color: _kColor,
          fontFamily: 'Futura',
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: _kColor,
          fontFamily: 'Futura',
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: _kColor,
          fontFamily: 'Futura',
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: _kColor,
          fontWeight: FontWeight.w300,
          fontFamily: 'Futura',
          fontSize: 14,
        ),
      );

  static Color get _kColor => Colors.black;
}
