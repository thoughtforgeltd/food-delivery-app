import 'package:flutter/material.dart';

enum ConsoleActions { dishes, add_dish, meal_types }

extension ConsoleActionsExtension on ConsoleActions {
  String get title {
    switch (this) {
      case ConsoleActions.add_dish:
        return 'Add Dish';
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
      case ConsoleActions.add_dish:
        return Icons.note_add;
      case ConsoleActions.dishes:
        return Icons.fastfood;
      case ConsoleActions.meal_types:
        return Icons.restaurant_menu;
      default:
        return null;
    }
  }
}
