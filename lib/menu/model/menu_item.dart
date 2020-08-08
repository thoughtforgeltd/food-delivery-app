import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(nullable: true)
class MenuItem {
  Category category;
  List<Dish> dishes;

  MenuItem({this.category, this.dishes});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  @override
  String toString() {
    return '''MenuItem {
      category: $category,
      dishes: $dishes,
    }''';
  }
}
