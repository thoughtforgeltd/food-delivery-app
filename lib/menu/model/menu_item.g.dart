// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  return MenuItem(items: json as Map<String, List<String>>);
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) =>
    new Map.fromIterable(instance.items.entries,
        key: (item) => (item as MapEntry<String, List<String>>).key,
        value: (item) => (item as MapEntry<String, List<String>>)
            .value
            .map((e) => e)
            .toList());
