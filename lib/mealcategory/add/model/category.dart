import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(nullable: true)
class Category {
  String id;
  String title;
  String description;
  String image;

  Category({this.id, this.title, this.description, this.image});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return '''Category {
      id: $id,
      title: $title,
      description: $description,
      image: $image,
    }''';
  }
}
