import 'package:flutter/material.dart';

enum BottomNavigationOptions{
  today,
  meals_timeline,
  profile
}

extension BottomNavigationOptionsExtension on BottomNavigationOptions {
  String get title {
    switch (this) {
      case BottomNavigationOptions.today:
        return 'Today';
      case BottomNavigationOptions.meals_timeline:
        return 'Timeline';
      case BottomNavigationOptions.profile:
        return 'Profile';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavigationOptions.today:
        return Icons.today;
      case BottomNavigationOptions.meals_timeline:
        return Icons.timeline;
      case BottomNavigationOptions.profile:
        return Icons.person;
      default:
        return null;
    }
  }
}