import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

import '../add_schedule.dart';

class MenuView {
  Map<DateTime, List<MenuItemView>> items;

  MenuView({this.items});

  @override
  String toString() {
    return '''MenuView {
      items: $items,
    }''';
  }
}

extension MenuViewMapper on MenuView {
  Menu toMenu() {
    if (this == null) return null;
    return Menu(
        items: new Map.fromIterable(this.items.entries,
            key: (item) => (item as MapEntry<DateTime, List<MenuItemView>>)
                .key
                .toMenuDate(),
            value: (item) => (item as MapEntry<DateTime, List<MenuItemView>>)
                .value
                .map((e) => e.toMenuItem())
                .toList()));
  }
}

extension MenuMapper on Menu {
  MenuView toMenuView(Categories categories, Dishes dishes) {
    if (this == null) return null;
    return MenuView(
        items: new Map.fromIterable(this.items.entries,
            key: (item) => DateTime.parse(item),
            value: (item) => (item as List<MenuItem>)
                .map((e) => e.toMenuItemView(categories, dishes))));
  }
}
