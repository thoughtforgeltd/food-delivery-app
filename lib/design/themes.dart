import 'package:flutter/material.dart';

import 'colors.dart';

class MealDeliveryThemes {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.colorPrimary,
      primaryColorDark: AppColors.colorPrimaryDark,
      accentColor: AppColors.colorPrimaryAccent,
      buttonTheme: buttonTheme);

  static final ButtonThemeData buttonTheme = ButtonThemeData(
      buttonColor: AppColors.colorPrimaryDark,
      textTheme: ButtonTextTheme.primary);
}
