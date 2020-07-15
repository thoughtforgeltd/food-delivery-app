import 'package:flutter/material.dart';

class UpdateMealArguments {
  final void Function(String) onEditPressed;

  UpdateMealArguments({@required Function(String) onEditPressed})
      : onEditPressed = onEditPressed;
}
