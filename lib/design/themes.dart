import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MealDeliveryThemes {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.colorPrimary,
      primaryColorDark: AppColors.colorPrimaryDark,
      accentColor: AppColors.colorPrimaryAccent,
      buttonTheme: buttonTheme,
      textTheme: GoogleFonts.robotoTextTheme());

  static final ButtonThemeData buttonTheme = ButtonThemeData(
      buttonColor: AppColors.colorPrimaryDark,
      disabledColor: AppColors.colorDisable,
      textTheme: ButtonTextTheme.primary);
}
