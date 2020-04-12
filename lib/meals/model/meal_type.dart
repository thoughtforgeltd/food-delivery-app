import 'package:json_annotation/json_annotation.dart';

part 'meal_type.g.dart';

@JsonSerializable()
class MealType {
  String id;
  String title;

  MealType({this.id, this.title});

  factory MealType.fromJson(Map<String, dynamic> json) => _$MealTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MealTypeToJson(this);
}
