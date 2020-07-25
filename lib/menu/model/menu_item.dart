import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(nullable: true)
class MenuItem {
  Map<String, List<String>> items;

  MenuItem({this.items});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  @override
  String toString() {
    return '''MenuItem {
      items: $items,
    }''';
  }
}
