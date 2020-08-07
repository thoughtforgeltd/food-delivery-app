import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MealDeliveryThemes {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.colorPrimary,
      primaryColorDark: AppColors.colorPrimaryDark,
      primaryColorLight: AppColors.colorPrimaryLight,
      primaryColorBrightness: Brightness.dark,
      accentColor: AppColors.colorPrimaryAccent,
      accentColorBrightness: Brightness.dark,
      disabledColor: AppColors.colorDisable,
      errorColor: AppColors.colorError,
      primarySwatch: MaterialColor(
          AppColors.colorPrimary.value, AppColors.primarySwatchColors),
      buttonTheme: buttonTheme,
      textTheme: GoogleFonts.robotoTextTheme(),
      iconTheme: iconThemeData);

  static final ButtonThemeData buttonTheme = ButtonThemeData(
      buttonColor: AppColors.colorPrimaryDark,
      disabledColor: AppColors.colorDisable,
      textTheme: ButtonTextTheme.primary);

  static final IconThemeData iconThemeData =
      IconThemeData(color: AppColors.colorPrimaryDark);
}
