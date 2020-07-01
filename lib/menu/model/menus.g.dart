// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menus _$MenusFromJson(Map<String, dynamic> json) {
  return Menus(
    meals: (json['meals'] as List)
            ?.map((e) =>
                e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$MenusToJson(Menus instance) => <String, dynamic>{
      'meals': instance.meals,
    };
