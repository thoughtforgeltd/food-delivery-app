import 'package:fooddeliveryapp/meals/model/schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable(nullable: true)
class Meal {
  num date;

  @JsonKey(defaultValue: [])
  List<Schedules> schedules = List();

  Meal({this.date, this.schedules});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

  @override
  String toString() {
    return '''Meal {
      date: $date,
      schedules: $schedules,
    }''';
  }
}
