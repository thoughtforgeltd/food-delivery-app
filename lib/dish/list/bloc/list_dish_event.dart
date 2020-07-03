import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:meta/meta.dart';

abstract class ListDishEvent extends Equatable {
  const ListDishEvent();

  @override
  List<Object> get props => [];
}

class LoadDishesEvent extends ListDishEvent {}

class DeleteDishEvent extends ListDishEvent {
  final Dish dish;

  const DeleteDishEvent({@required this.dish});

  @override
  List<Object> get props => [dish];

  @override
  String toString() => 'DeleteDishEvent { dish :$dish }';
}

class EditDishEvent extends ListDishEvent {
  final String id;

  const EditDishEvent({@required this.id});

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'EditDishEvent { id :$id }';
}
