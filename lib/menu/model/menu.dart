import 'package:fooddeliveryapp/menu/model/menu_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable(nullable: true)
class Menu {
  String id;
  String title;
  MenuItem item;

  Menu({this.id, this.title, this.item});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  @override
  String toString() {
    return '''Menu {
      id: $id,
      title: $title,
      item: $item,
    }''';
  }
}
