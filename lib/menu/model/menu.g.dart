// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  if (json == null) return null;
  final items = json['items'] ?? null;
  final date = json['date'] ?? null;
  return Menu(
      date: date != null ? (date as Timestamp).toDate() : null,
      items: items != null
          ? (items as List)?.map((e) => MenuItem.fromJson(e))?.toList()
          : []);
}

Map<String, dynamic> _$MenuToJson(Menu instance) => {
      'date': instance.date,
      'items': instance.items?.map((e) => e?.toJson())?.toList()
    };
