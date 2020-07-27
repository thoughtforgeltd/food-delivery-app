import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';

import '../add_schedule.dart';

class MenuView {
  DateTime date;
  List<MenuItemView> items;

  MenuView({this.date, this.items});

  @override
  String toString() {
    return '''MenuView {
      date: $date,
      items: $items,
    }''';
  }
}

extension MenuViewMapper on MenuView {
  Menu toMenu() {
    if (this == null) return null;
    return Menu(
        date: this.date,
        items: this.items?.map((e) => e?.toMenuItem())?.toList());
  }
}

extension MenuMapper on Menu {
  MenuView toMenuView(Categories categories, Dishes dishes) {
    if (this == null) return null;
    return MenuView(
        date: this.date,
        items: this
            .items
            ?.map((e) => e.toMenuItemView(categories, dishes))
            ?.toList());
  }
}
