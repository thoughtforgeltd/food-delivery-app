import 'package:flutter/material.dart';

class AddCategoryArguments {
  final void Function(String) onAddPressed;

  AddCategoryArguments({@required Function(String) onAddPressed})
      : onAddPressed = onAddPressed;
}
