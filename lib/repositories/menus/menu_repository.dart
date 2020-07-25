import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/menu/model/menus.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';

class MenuRepository {
  final CollectionReference _collection;
  static String _path = 'menus';

  MenuRepository() : _collection = Firestore.instance.collection(_path);

  /// Pass the date in format of dd-mm-yyyy
  Future<Menus> loadTodayMenu(String date) async {
    final document = await _collection.document(date).get();
    return Future.value(Menus.fromJson(document.data));
  }

  Future<Menu> loadMenus() async {
    final collection = await _collection.document(_path).get();
    return Future.value(Menu.fromJson(collection.data));
  }

  Future<void> addMenu(MenuItem menuItem) async {
    return _collection.add(menuItem.toJson());
  }

  Future<void> addMenus(Menus menus) async {
    return _collection.document("menus").setData(menus.toJson());
  }
}
