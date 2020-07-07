import 'package:flutter/material.dart';

enum ConsoleActions { edit_profile, contact_us, console }

extension ConsoleActionsExtension on ConsoleActions {
  String get title {
    switch (this) {
      case ConsoleActions.edit_profile:
        return 'Edit Profile';
      case ConsoleActions.contact_us:
        return 'Contact Us';
      case ConsoleActions.console:
        return 'Console';
      default:
        return null;
    }
  }

  IconData get icon {
    switch (this) {
      case ConsoleActions.edit_profile:
        return Icons.person;
      case ConsoleActions.contact_us:
        return Icons.call;
      case ConsoleActions.console:
        return Icons.settings;
      default:
        return null;
    }
  }
}
