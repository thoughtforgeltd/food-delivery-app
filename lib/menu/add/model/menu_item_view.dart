import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/mealcategory/categories/categories.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';

class MenuItemView {
  Map<Category, List<Dish>> item;

  MenuItemView({this.item});

  @override
  String toString() {
    return '''MenuItemView {
      item: $item,
    }''';
  }
}

extension MenuItemViewMapper on MenuItemView {
  MenuItem toMenuItem() {
    if (this == null) return null;
    return MenuItem(
        items: new Map.fromIterable(this.item.entries,
            key: (item) => (item as MapEntry<Category, List<Dish>>).key.id,
            value: (item) => (item as MapEntry<Category, List<Dish>>)
                .value
                .map((e) => e.id)
                .toList()));
  }
}

extension MenuItemMapper on MenuItem {
  MenuItemView toMenuItemView(Categories categories, Dishes dishes) {
    if (this == null) return null;
    return MenuItemView(
        item: new Map.fromIterable(this.items.entries,
            key: (item) => categories.categories
                .firstWhere((element) => element.id == item, orElse: null),
            value: (item) => (item as List<String>).map((e) => dishes.dishes
                .firstWhere((element) => element.id == e, orElse: null))));
  }
}
