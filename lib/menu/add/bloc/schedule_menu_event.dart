import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:meta/meta.dart';

import '../add_schedule.dart';

abstract class ScheduleMenuEvent extends Equatable {
  const ScheduleMenuEvent();

  @override
  List<Object> get props => [];
}

class MenuSchedulesLoaded extends ScheduleMenuEvent {}

class DateChanged extends ScheduleMenuEvent {
  final DateTime selectedDate;

  const DateChanged({@required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];

  @override
  String toString() => 'DateChanged { selectedDate :$selectedDate }';
}

class CategoryChanged extends ScheduleMenuEvent {
  final Category category;

  const CategoryChanged({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'CategoryChanged { category :$category }';
}

class AddDishSchedule extends ScheduleMenuEvent {
  final Dish dish;

  const AddDishSchedule({
    @required this.dish,
  });

  @override
  List<Object> get props => [dish];

  @override
  String toString() {
    return 'AddMenuSchedule { dish: $dish}';
  }
}

class RemoveDishEvent extends ScheduleMenuEvent {
  final Dish dish;

  const RemoveDishEvent({
    @required this.dish,
  });

  @override
  List<Object> get props => [dish];

  @override
  String toString() {
    return 'RemoveDishEvent { dish: $dish}';
  }
}

class Submitted extends ScheduleMenuEvent {
  final DateTime selectedDate;
  final MenusView menus;
  final bool handleSubmitted;

  const Submitted({
    @required this.selectedDate,
    @required this.menus,
    @required this.handleSubmitted,
  });

  @override
  List<Object> get props => [selectedDate, menus, handleSubmitted];

  @override
  String toString() {
    return 'Submitted { selectedDate: $selectedDate, menus: $menus handleSubmitted:$handleSubmitted }';
  }
}
