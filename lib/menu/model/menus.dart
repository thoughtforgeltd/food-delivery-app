import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menus.g.dart';

@JsonSerializable(nullable: true)
class Menus {
  @JsonKey(defaultValue: [])
  List<Menu> menus = List();

  Menus({this.menus});

  factory Menus.fromJson(Map<String, dynamic> json) => _$MenusFromJson(json);

  Map<String, dynamic> toJson() => _$MenusToJson(this);

  @override
  String toString() {
    return '''Menus {
      menus: $menus,
    }''';
  }
}
