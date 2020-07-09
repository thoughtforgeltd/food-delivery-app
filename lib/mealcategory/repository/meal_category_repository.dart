import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class MealCategoryRepository {
  final CollectionReference _collection;
  static String _path = FireStorePaths.KEY_CONFIGURATIONS_COLLECTIONS;
  static String _document = FireStorePaths.KEY_DOCUMENT_MEAL_CATEGORY_TYPE;

  MealCategoryRepository() : _collection = Firestore.instance.collection(_path);

  Future<MealCategoryIcons> getMealCategoryIcons() async {
    final document = await _collection.document(_document).get();
    return Future.value(MealCategoryIcons.fromJson(document.data));
  }
}
