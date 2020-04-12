import 'package:cloud_firestore/cloud_firestore.dart';

class MealScheduleRepository {
  final CollectionReference _collection;
  static String _path = 'meals';

  MealScheduleRepository() : _collection = Firestore.instance.collection(_path);

  Future<void> updateMealSchedulesForTheDay(
      String userId, DateTime selectedDate, Map<String, Map<String, bool>> mealsSelection) {
    return _collection.document(userId).setData(mealsSelection, merge: true);
  }

  Future<Map<String, dynamic>> getMealSelections(String userID) async{
    final document = await _collection.document(userID).get();
    return Future.value(document.data);
  }

  Future<DocumentSnapshot> getMealSelectionsForTheDay(String userID, DateTime date) async{
    final meals = await getMealSelections(userID);
    return Future.value(meals[date.millisecondsSinceEpoch]);
  }
}
