import 'package:json_annotation/json_annotation.dart';

part 'meal_type.g.dart';

@JsonSerializable(nullable: true)
class MealType {
  String id;
  String title;
  String icon;

  MealType({this.id, this.title, this.icon});

  factory MealType.fromJson(Map<String, dynamic> json) => _$MealTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MealTypeToJson(this);

  @override
  String toString() {
    return '''MealType {
      id: $id,
      title: $title
      icon: $icon
    }''';
  }
}
