import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable(nullable: true)
class Dish {
  String id;
  String title;
  String description;
  String image;
  String note;

  Dish({this.id, this.title, this.description, this.image, this.note});

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);

  @override
  String toString() {
    return '''Dish {
      id: $id,
      title: $title,
      description: $description,
      image: $image,
      note: $note,
    }''';
  }
}
