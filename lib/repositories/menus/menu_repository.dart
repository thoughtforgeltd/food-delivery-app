import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/menu/model/menus.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

class MenuRepository {
  final CollectionReference _collection;
  static String _path = 'menus';

  MenuRepository() : _collection = Firestore.instance.collection(_path);

  Future<Menus> loadTodayMenu(DateTime date) async {
    final document = await loadMenus();
    document.menus.retainWhere((element) => element.date.isSameDay(date));
    return Future.value(document);
  }

  Future<Menus> loadMenus() async {
    final collection = await _collection.document(_path).get();
    return Future.value(Menus.fromJson(collection.data));
  }

  Future<void> addMenu(MenuItem menuItem) async {
    return _collection.add(menuItem.toJson());
  }

  Future<void> addMenus(Menus menus) async {
    return _collection.document("menus").setData(menus.toJson());
  }
}
