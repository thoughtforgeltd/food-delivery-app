import 'package:fooddeliveryapp/meals/model/schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  num date;
  List<Schedules> schedules;

    Meal({this.date, this.schedules});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
