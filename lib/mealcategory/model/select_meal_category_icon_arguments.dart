import 'package:flutter/material.dart';

class SelectMealCategoryIconArgs {
  final void Function(String) onIconSelected;

  SelectMealCategoryIconArgs({@required Function(String) onIconSelected})
      : onIconSelected = onIconSelected;
}
