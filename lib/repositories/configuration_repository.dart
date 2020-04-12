import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/repositories/paths/firebase_congiguration_paths.dart';

class ConfigurationsRepository {
  final CollectionReference _collection;
  static String _path = FireStorePaths.KEY_CONFIGURATIONS_COLLECTIONS;
  static String _document = FireStorePaths.KEY_DOCUMENT_MEAL_TYPE;
  static String _key = FireStorePaths.KEY_MEAL_TYPE;

  ConfigurationsRepository() : _collection = Firestore.instance.collection(_path);

  Future<MealTypeConfigurations> getMealTypeConfigurations() async{
    final document = await _collection.document(_document).get();
    return Future.value(MealTypeConfigurations.fromJson(document.data));
  }
}
