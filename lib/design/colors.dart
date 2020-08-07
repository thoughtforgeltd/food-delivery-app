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
  static final colorError = Colors.red;

  static final colorPrimary900 = Color(0xff15212A);
  static final colorPrimary800 = Color(0xff21313B);
  static final colorPrimary700 = Color(0xff273944);
  static final colorPrimary600 = Color(0xff2F424E);
  static final colorPrimary500 = Color(0xff344955);
  static final colorPrimary400 = Color(0xff52646F);
  static final colorPrimary300 = Color(0xff718088);
  static final colorPrimary200 = Color(0xff9AA4AA);
  static final colorPrimary100 = Color(0xffC2C8CC);
  static final colorPrimary50 = Color(0xffE7E9EB);

  static final primarySwatchColors = {
    50: colorPrimary50,
    100: colorPrimary100,
    200: colorPrimary200,
    300: colorPrimary300,
    400: colorPrimary400,
    500: colorPrimary500,
    600: colorPrimary600,
    700: colorPrimary700,
    800: colorPrimary800,
    900: colorPrimary900,
  };
}
