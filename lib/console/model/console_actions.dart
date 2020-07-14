import 'package:flutter/material.dart';

enum ConsoleActions { dishes, meal_types }

extension ConsoleActionsExtension on ConsoleActions {
  String get title {
    switch (this) {
      case ConsoleActions.dishes:
        return 'Dishes';
      case ConsoleActions.meal_types:
        return 'Meal Types';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case ConsoleActions.dishes:
        return Icons.fastfood;
      case ConsoleActions.meal_types:
        return Icons.restaurant_menu;
      default:
        return null;
    }
  }
}
