import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryAddedEvent extends AddCategoryEvent {}

class CategoryTitleChangedEvent extends AddCategoryEvent {
  final String title;

  const CategoryTitleChangedEvent({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'CategoryTitleChangedEvent { title :$title }';
}

class CategoryDescriptionChangedEvent extends AddCategoryEvent {
  final String description;

  const CategoryDescriptionChangedEvent({@required this.description});

  @override
  List<Object> get props => [description];

  @override
  String toString() =>
      'CategoryDescriptionChangedEvent { description :$description }';
}

class CategoryImageAddedEvent extends AddCategoryEvent {
  final String path;

  const CategoryImageAddedEvent({@required this.path});

  @override
  List<Object> get props => [path];

  @override
  String toString() => 'CategoryImageAddedEvent { image_path :$path }';
}

class OnAddCategoryPressedEvent extends AddCategoryEvent {
  final String title;
  final String description;
  final String imagePath;

  const OnAddCategoryPressedEvent(
      {@required this.title,
      @required this.description,
      @required this.imagePath});

  @override
  List<Object> get props => [title, description, imagePath];

  @override
  String toString() =>
      'OnAddCategoryPressedEvent { title :$title description:$description imagePath$imagePath}';
}
