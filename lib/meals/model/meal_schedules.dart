import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_schedules.g.dart';

@JsonSerializable(nullable: true)
class MealSchedules {
  @JsonKey(defaultValue: [])
  List<Meal> meals = List();

  MealSchedules({this.meals});

  factory MealSchedules.fromJson(Map<String, dynamic> json) => _$MealSchedulesFromJson(json);

  Map<String, dynamic> toJson() => _$MealSchedulesToJson(this);

  @override
  String toString() {
    return '''MealSchedules {
      meals: $meals,
    }''';
  }
}
