

import 'package:flutter/material.dart';

class AddDishArguments {
  final void Function(String) onAddPressed;
  AddDishArguments(
      { @required Function(String) onAddPressed})
      : onAddPressed = onAddPressed;
}