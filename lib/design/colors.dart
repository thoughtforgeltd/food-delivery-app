import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
  static const double alpha = 0.38;
  static final colorPrimary = Color(0xff344955);
  static final colorPrimaryDark = Color(0xff0b222c);
  static final colorPrimaryLight = Color(0xff5f7481);
  static final colorPrimaryAccent = Color(0xffc07605);
  static final colorDisable = colorPrimaryDark.withOpacity(alpha);
  static final colorTransparent = Colors.transparent;
  static final colorSurface = Color(0xfff5f5f5);

  static final colorScheme = ColorScheme(
      primary: colorPrimary,
      primaryVariant: colorPrimaryLight,
      secondary: colorPrimaryAccent,
      secondaryVariant: colorPrimaryAccent,
      surface: Colors.white,
      background: colorSurface,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light);
}
