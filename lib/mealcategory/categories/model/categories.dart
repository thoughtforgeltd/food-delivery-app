import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class Categories {
  List<Category> categories;

  Categories({this.categories});

  factory Categories.fromDocuments(List<DocumentSnapshot> documents) {
    return Categories(
        categories: documents?.map((e) {
              final dish = Category.fromJson(e.data);
              return Category(
                  id: e.reference.documentID,
                  title: dish.title,
                  description: dish.description,
                  image: dish.image);
            })?.toList() ??
            List());
  }

  @override
  String toString() {
    return '''Categories {
      categories: $categories,
    }''';
  }
}
