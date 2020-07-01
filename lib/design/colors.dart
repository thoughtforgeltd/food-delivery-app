import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors{
  static const double alpha = 0.38;
  static final colorPrimary = Color(0xff344955);
  static final colorPrimaryDark = Color(0xff232F34);
  static final colorPrimaryLight = Color(0xff4A6572);
  static final colorPrimaryAccent = Color(0xffc07605);
  static final colorWhite = Colors.white;
  static final colorDisable = colorPrimaryDark.withOpacity(alpha);
  static final colorTransparent = Colors.transparent;
}
