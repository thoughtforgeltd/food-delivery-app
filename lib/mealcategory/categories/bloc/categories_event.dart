import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../meal_category.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {}

class DeleteCategoryEvent extends CategoriesEvent {
  final Category category;

  const DeleteCategoryEvent({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'DeleteCategoryEvent { Category :$category }';
}

class EditCategoryEvent extends CategoriesEvent {
  final String id;

  const EditCategoryEvent({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'EditCategoryEvent { id :$id }';
}
