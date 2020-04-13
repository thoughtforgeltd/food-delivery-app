import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable(nullable: true)
class Schedules {
  String id;
  int quantity;

  Schedules({this.id, this.quantity});

  factory Schedules.fromJson(Map<String, dynamic> json) => _$SchedulesFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulesToJson(this);

  @override
  String toString() {
    return '''Schedules {
      id: $id,
      quantity: $quantity
    }''';
  }
}
