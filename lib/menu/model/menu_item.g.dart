// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final dishes = json['dishes'] ?? null;
  return MenuItem(
      category: Category(id: json['category']),
      dishes: dishes != null ? dishes as List<String> : []);
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => {
      'category': instance.category.id,
      'dishes': instance.dishes?.map((e) => e.id)?.toList()
    };
