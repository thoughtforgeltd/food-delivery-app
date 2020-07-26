// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final items = json['items'] ?? null;
  return Menu(
      date: DateTime.parse(json['date']),
      items: items != null
          ? (items as List)?.map((e) => MenuItem.fromJson(e))
          : []);
}

Map<String, dynamic> _$MenuToJson(Menu instance) => {
      'date': instance.date,
      'items': instance.items?.map((e) => e?.toJson())?.toList()
    };
