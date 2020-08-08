import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

import '../add_schedule.dart';

class MenusView {
  List<MenuView> menus;

  MenusView({this.menus});

  @override
  String toString() {
    return '''MenusView {
      menus: $menus,
    }''';
  }
}

extension MenusViewMapper on MenusView {
  Menus toMenus() {
    if (this == null) return null;
    return Menus(menus: this.menus?.map((e) => e.toMenu())?.toList());
  }

  MenuView getMenuView(DateTime date) {
    return this?.menus?.firstWhere((element) => element.date.isSameDay(date),
            orElse: () => null) ??
        null;
  }
}

extension MenusMapper on Menus {
  MenusView toMenusView(Categories categories, Dishes dishes) {
    if (this == null) return null;
    return MenusView(
        menus:
        this.menus?.map((e) => e?.toMenuView(categories, dishes))?.toList());
  }
}
