import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/menu/model/menus.dart';

class TodayMenuRepository {
  final CollectionReference _collection;
  static String _path = 'menus';

  TodayMenuRepository() : _collection = Firestore.instance.collection(_path);

  /// Pass the date in format of dd-mm-yyyy
  Future<Menus> loadTodayMenu(String date) async {
    final document = await _collection.document(date).get();
    return Future.value(Menus.fromJson(document.data));
  }
}
