// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menus _$MenusFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final meals = json['menus'] ?? Map<String, Menu>();
  return Menus(
    menus: (meals as List)
            ?.map((e) =>
                e == null ? null : Menu.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$MenusToJson(Menus instance) =>
    <String, dynamic>{
      'menus': instance.menus.map((e) => e.toJson()).toList(),
    };
