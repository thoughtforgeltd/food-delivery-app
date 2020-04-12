// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_type_configurations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealTypeConfigurations _$MealTypeConfigurationsFromJson(
    Map<String, dynamic> json) {
  return MealTypeConfigurations(
    types: (json['types'] as List)
        ?.map((e) =>
            e == null ? null : MealType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MealTypeConfigurationsToJson(
        MealTypeConfigurations instance) =>
    <String, dynamic>{
      'types': instance.types,
    };
