import 'package:flutter/material.dart';

enum ConsoleActions { dishes, meal_types, menu }

extension ConsoleActionsExtension on ConsoleActions {
  String get title {
    switch (this) {
      case ConsoleActions.dishes:
        return 'Dishes';
      case ConsoleActions.meal_types:
        return 'Meal Types';
      case ConsoleActions.menu:
        return 'Menu';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case ConsoleActions.dishes:
        return Icons.fastfood;
      case ConsoleActions.meal_types:
        return Icons.restaurant;
      case ConsoleActions.menu:
        return Icons.restaurant_menu;
      default:
        return null;
    }
  }

  void navigate(BuildContext context) {
    switch (this) {
      case ConsoleActions.dishes:
        Navigator.of(context).pushNamed('/dishes');
        break;
      case ConsoleActions.meal_types:
        Navigator.of(context).pushNamed('/categories');
        break;
      case ConsoleActions.menu:
        Navigator.of(context).pushNamed('/schedule_menu');
        break;
    }
  }
}
