// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedules _$SchedulesFromJson(Map<String, dynamic> json) {
  return Schedules(
    id: json['id'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$SchedulesToJson(Schedules instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
    };
