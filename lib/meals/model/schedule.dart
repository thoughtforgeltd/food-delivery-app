import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedules {
  String id;
  int quantity;

  Schedules({this.id, this.quantity});

  factory Schedules.fromJson(Map<String, dynamic> json) => _$SchedulesFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulesToJson(this);
}
