// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_schedules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealSchedules _$MealSchedulesFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final meal = json['meals'] ?? Map();
  final meals = (meal as List)
          ?.map((e) =>
              e == null ? null : Meal.fromJson(e as Map<String, dynamic>))
          ?.toList() ??
      [];
  meals?.sort((a, b) => a.date.compareTo(b.date));
  return MealSchedules(
    meals: meals,
  );
}

Map<String, dynamic> _$MealSchedulesToJson(MealSchedules instance) =>
    <String, dynamic>{
      'meals': instance.meals.map((e) => e.toJson()).toList(),
    };
