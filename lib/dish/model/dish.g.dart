// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) {
  return Dish(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    note: json['note'] as String,
  );
}

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'note': instance.note,
    };
