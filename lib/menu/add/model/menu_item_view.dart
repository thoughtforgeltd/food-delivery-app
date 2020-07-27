import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/mealcategory/categories/categories.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';

class MenuItemView {
  Category category;
  List<Dish> dishes;

  MenuItemView({this.category, this.dishes});

  @override
  String toString() {
    return '''MenuItemView {
      category: $category,
      dishes: $dishes,
    }''';
  }
}

extension MenuItemViewMapper on MenuItemView {
  MenuItem toMenuItem() {
    if (this == null) return null;
    return MenuItem(dishes: this.dishes, category: this.category);
  }
}

extension MenuItemMapper on MenuItem {
  MenuItemView toMenuItemView(Categories categories, Dishes dishes) {
    if (this == null) return null;
    return MenuItemView(
        dishes: dishes.dishes
            ?.where((dish) =>
                this.dishes?.firstWhere((element) => dish.id == element.id,
                    orElse: () => null) !=
                null)
            ?.toList(),
        category: categories.categories?.firstWhere(
            (element) => element?.id == this.category?.id,
            orElse: () => null));
  }
}
