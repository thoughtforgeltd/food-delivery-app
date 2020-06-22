// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) {
  if(json == null) return null;
  final schedules = json['schedules'] ?? Map();
  return Meal(
    date: json['date'] as Timestamp,
    schedules: (schedules as List)
            ?.map((e) => e == null
                ? null
                : Schedules.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'date': instance.date,
      'schedules': instance.schedules.map((e) => e.toJson()).toList(),
    };
