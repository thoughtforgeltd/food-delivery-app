import 'package:fooddeliveryapp/meals/model/schedule.dart';

import 'meal_type.dart';

class MealSelection{
  DateTime date;
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
