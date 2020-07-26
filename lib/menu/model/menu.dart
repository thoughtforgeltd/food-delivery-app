import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable(nullable: true)
class Menu {
  DateTime date;
  List<MenuItem> items;

  Menu({this.date, this.items});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  @override
  String toString() {
    return '''Menu {
      date: $date,
      dishes: $items,
    }''';
  }
}