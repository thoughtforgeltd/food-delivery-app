import 'package:fooddeliveryapp/menu/model/menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menus.g.dart';

@JsonSerializable(nullable: true)
class Menus {
  @JsonKey(defaultValue: [])
  List<Menu> meals = List();

  Menus({this.meals});

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);

  @override
  String toString() {
    return '''Menus {
      meals: $meals,
    }''';
  }
}
