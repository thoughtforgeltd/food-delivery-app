import 'package:json_annotation/json_annotation.dart';

part 'meal_category_icons.g.dart';

@JsonSerializable(nullable: true)
class MealCategoryIcons {
  @JsonKey(defaultValue: [])
  List<String> icons;

  MealCategoryIcons({this.icons});

  factory MealCategoryIcons.fromJson(Map<String, dynamic> json) =>
      _$MealCategoryIconsFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoryIconsToJson(this);

  @override
  String toString() {
    return '''MealCategoryIcons {
      icons: $icons
    }''';
  }
}
