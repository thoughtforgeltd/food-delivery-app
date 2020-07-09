// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_category_icons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCategoryIcons _$MealCategoryIconsFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final icons = (json['icons'] ?? []);
  final output =
      (icons as List)?.map((e) => e == null ? null : e as String)?.toList() ??
          [];
  return MealCategoryIcons(icons: output);
}

Map<String, dynamic> _$MealCategoryIconsToJson(MealCategoryIcons instance) =>
    <String, dynamic>{
      'icons': instance.icons,
    };
