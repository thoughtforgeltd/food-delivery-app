import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class MealSelection{
  Timestamp date;
  Schedules schedules;
  MealType configurations;

  MealSelection({this.date, this.schedules, this.configurations});

  @override
  String toString() {
    return '''MealSelection {
      date: $date,
      schedules: $schedules,
      configurations: $configurations
    }''';
  }
}
