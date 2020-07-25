import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable(nullable: true)
class Menu {
  Map<String, List<MenuItem>> items;

  Menu({this.items});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  @override
  String toString() {
    return '''Menu {
      dishes: $items,
    }''';
  }
}