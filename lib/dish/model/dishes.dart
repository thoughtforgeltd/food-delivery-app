import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class Dishes {
  List<Dish> dishes;

  Dishes({this.dishes});

  factory Dishes.fromDocuments(List<DocumentSnapshot> documents) {
    return Dishes(
        dishes: documents?.map((e) {
              final dish = Dish.fromJson(e.data);
              return Dish(
                  id: e.reference.documentID,
                  title: dish.title,
                  description: dish.description,
                  note: dish.note,
                  image: dish.image);
            }) ??
            List());
  }

  @override
  String toString() {
    return '''Dishes {
      dishes: $dishes,
    }''';
  }
}
