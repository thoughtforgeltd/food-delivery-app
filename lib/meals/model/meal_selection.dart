import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

import 'model.dart';

class MealSelection{
  Timestamp date;
  Schedules schedules;
  Category category;

  MealSelection({this.date, this.schedules, this.category});

  @override
  String toString() {
    return '''MealSelection {
      date: $date,
      schedules: $schedules,
      category: $category
    }''';
  }
}
