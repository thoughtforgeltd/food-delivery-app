// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  return Menu(
      items: json.map((key, value) =>
          value?.map((e) => e == null ? null : e as MenuItem)?.toList() ?? []));
}

Map<String, dynamic> _$MenuToJson(Menu instance) =>
    new Map.fromIterable(instance.items.entries,
        key: (item) => (item as MapEntry<String, List<MenuItem>>).key,
        value: (item) =>
            (item as MapEntry<String, List<MenuItem>>)
                .value
                .map((e) => e.toJson())
                .toList());
