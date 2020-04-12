import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_schedules.g.dart';

@JsonSerializable()
class MealSchedules {
  List<Meal> meals;

  MealSchedules({this.meals});

  factory MealSchedules.fromJson(Map<String, dynamic> json) => _$MealSchedulesFromJson(json);

  Map<String, dynamic> toJson() => _$MealSchedulesToJson(this);
}
