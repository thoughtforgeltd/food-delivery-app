import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {
  static final regular = TextStyle(color: AppColors.colorPrimary);
  static final regularDisabled = TextStyle(color: AppColors.colorDisable);
  static final bold = TextStyle(color: AppColors.colorPrimary, fontWeight: FontWeight.bold);
  static final disabledBold = TextStyle(color: AppColors.colorDisable, fontWeight: FontWeight.bold);
}
