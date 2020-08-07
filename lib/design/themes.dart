import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MealDeliveryThemes {
  static final ThemeData lightTheme = ThemeData.from(
          colorScheme: AppColors.colorScheme,
          textTheme: GoogleFonts.robotoTextTheme())
      .copyWith(buttonTheme: buttonTheme, chipTheme: cheapTheme);

//  ThemeData(
//      brightness: Brightness.light,
//      primaryColor: AppColors.colorPrimary,
//      primaryColorDark: AppColors.colorPrimaryDark,
//      primaryColorLight: AppColors.colorPrimaryLight,
//      primaryColorBrightness: Brightness.dark,
//      accentColor: AppColors.colorPrimaryAccent,
//      accentColorBrightness: Brightness.dark,
//      disabledColor: AppColors.colorDisable,
//      errorColor: AppColors.colorError,
//      primarySwatch: MaterialColor(
//          AppColors.colorPrimary.value, AppColors.primarySwatchColors),
//      colorScheme: AppColors.colorScheme,
//      textTheme: GoogleFonts.robotoTextTheme(),
//      iconTheme: iconThemeData,
//      buttonTheme: buttonTheme);

  /// Currently button color is not picked up from color scheme so we have to add
  /// custom button theme.
  static final ButtonThemeData buttonTheme = ButtonThemeData(
      colorScheme: AppColors.colorScheme, textTheme: ButtonTextTheme.primary);

  static final ChipThemeData cheapTheme = ChipThemeData.fromDefaults(
      primaryColor: AppColors.colorScheme.primary,
      secondaryColor: AppColors.colorScheme.onPrimary,
      labelStyle: GoogleFonts
          .robotoTextTheme()
          .bodyText1).copyWith(
      selectedColor: AppColors.colorScheme.onPrimary,
      secondarySelectedColor: AppColors.colorScheme.primary);
}
