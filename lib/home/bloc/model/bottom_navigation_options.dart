import 'package:flutter/material.dart';

enum BottomNavigationOptions{
  meals_timeline,
  profile
}

extension BottomNavigationOptionsExtension on BottomNavigationOptions {
  String get title {
    switch (this) {
      case BottomNavigationOptions.meals_timeline:
        return 'Meals';
      case BottomNavigationOptions.profile:
        return 'Profile';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavigationOptions.meals_timeline:
        return Icons.restaurant_menu;
      case BottomNavigationOptions.profile:
        return Icons.person;
      default:
        return null;
    }
  }
}