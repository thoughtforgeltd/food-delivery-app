import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class MealCategoryRepository {
  final CollectionReference _iconCollection;
  static String _path = FireStorePaths.KEY_CONFIGURATIONS_COLLECTIONS;
  static String _document = FireStorePaths.KEY_DOCUMENT_MEAL_CATEGORY_TYPE;
  static String _pathCategories =
      FireStorePaths.KEY_DOCUMENT_MEAL_CATEGORIES_TYPE;

  MealCategoryRepository()
      : _iconCollection = Firestore.instance.collection(_path);

  Future<MealCategoryIcons> getMealCategoryIcons() async {
    final document = await _iconCollection.document(_document).get();
    return Future.value(MealCategoryIcons.fromJson(document.data));
  }

  Future<void> addCategory(Category category) async {
    return _iconCollection
        .document(_pathCategories)
        .collection(_pathCategories)
        .add(category.toJson());
  }

  Future<Categories> loadCategories() async {
    final collection = await _iconCollection
        .document(_pathCategories)
        .collection(_pathCategories)
        .getDocuments();
    return Future.value(Categories.fromDocuments(collection.documents));
  }

  Future<void> deleteCategory(Category category) async {
    final document = _iconCollection
        .document(_pathCategories)
        .collection(_pathCategories)
        .document(category.id);
    await Firestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(document);
    });
  }
}
