import 'package:cloud_firestore/cloud_firestore.dart';

class MealScheduleRepository {
  final CollectionReference _collection;
  static String _path = 'meals';

  MealScheduleRepository() : _collection = Firestore.instance.collection(_path);

  Future<void> updateMealSchedulesForTheDay(
      String userId, DateTime selectedDate, Map<String, bool> mealsSelection) {
    return _collection.document(userId).setData({
      "date": selectedDate.millisecondsSinceEpoch,
      "meals": mealsSelection,
    }, merge: true);
  }

  Future<DocumentSnapshot> getMealSelections(String userID) {
    return _collection.document(userID).get();
  }

  Future<DocumentSnapshot> getMealSelectionsForTheDay(String userID, DateTime date) {
    return _collection.document(userID).get();
  }
}
