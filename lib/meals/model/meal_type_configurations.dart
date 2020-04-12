
import 'package:fooddeliveryapp/meals/model/meal_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_type_configurations.g.dart';

@JsonSerializable()
class MealTypeConfigurations {
  List<MealType> types;

  MealTypeConfigurations({this.types});

  factory MealTypeConfigurations.fromJson(Map<String, dynamic> json) => _$MealTypeConfigurationsFromJson(json);

  Map<String, dynamic> toJson() => _$MealTypeConfigurationsToJson(this);
}
