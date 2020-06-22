import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';

class MealScheduleRepository {
  final CollectionReference _collection;
  static String _path = 'meals';

  MealScheduleRepository() : _collection = Firestore.instance.collection(_path);

  Future<void> updateMealSchedulesForTheDay(String userId,
      DateTime selectedDate, MealSchedules mealsSelection) {
    return _collection.document(userId).setData(mealsSelection.toJson(), merge: true);
  }

  Future<MealSchedules> getMealSelections(String userID) async {
    final document = await _collection.document(userID).get();
    return Future.value(MealSchedules.fromJson(document.data));
  }

  Future<Meal> getMealSelectionsForTheDay(String userID, DateTime date) async {
    final meals = await getMealSelections(userID);
    return Future.value(meals.meals
        .firstWhere((element) => element.date.millisecondsSinceEpoch == date.millisecondsSinceEpoch));
  }
}
