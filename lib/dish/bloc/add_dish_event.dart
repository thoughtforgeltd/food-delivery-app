import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddDishEvent extends Equatable {
  const AddDishEvent();

  @override
  List<Object> get props => [];
}

class LoadDishEvent extends AddDishEvent {}

class DishAddedEvent extends AddDishEvent {}

class DishTitleChangedEvent extends AddDishEvent {
  final String title;

  const DishTitleChangedEvent({@required this.title});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'DishTitleChangedEvent { title :$title }';
}

class DishDescriptionChangedEvent extends AddDishEvent {
  final String description;

  const DishDescriptionChangedEvent({@required this.description});

  @override
  List<Object> get props => [description];

  @override
  String toString() =>
      'DishDescriptionChangedEvent { description :$description }';
}

class DishImageAddedEvent extends AddDishEvent {
  final String path;

  const DishImageAddedEvent({@required this.path});

  @override
  List<Object> get props => [path];

  @override
  String toString() => 'DishImageAddedEvent { image_path :$path }';
}

class OnAddDishPressedEvent extends AddDishEvent {
  final String title;
  final String description;
  final String note;
  final String imagePath;

  const OnAddDishPressedEvent(
      {@required this.title,
      @required this.description,
      @required this.note,
      @required this.imagePath});

  @override
  List<Object> get props => [title, description, note, imagePath];

  @override
  String toString() =>
      'AddDishEvent { title :$title description:$description note:$note imagePath$imagePath}';
}
