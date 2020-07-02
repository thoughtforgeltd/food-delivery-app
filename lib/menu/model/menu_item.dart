import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable(nullable: true)
class MenuItem {
  String title;
  String description;
  String icon;

  MenuItem({this.title, this.description, this.icon});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  @override
  String toString() {
    return '''MenuItem {
      title: $title,
      description: $description,
      icon: $icon,
    }''';
  }
}
