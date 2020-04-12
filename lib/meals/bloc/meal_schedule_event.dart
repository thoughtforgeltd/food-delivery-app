import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:meta/meta.dart';

abstract class MealScheduleEvent extends Equatable {
  const MealScheduleEvent();

  @override
  List<Object> get props => [];
}

class MealSchedulesLoaded extends MealScheduleEvent{}

class DateChanged extends MealScheduleEvent {
  final DateTime selectedDate;

  const DateChanged({@required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];

  @override
  String toString() => 'DateChanged { selectedDate :$selectedDate }';
}

class MealSelectionChanged extends MealScheduleEvent {
  final MealSchedules mealsSelection;

  const MealSelectionChanged({@required this.mealsSelection});

  @override
  List<Object> get props => [mealsSelection];

  @override
  String toString() => 'MealSelectionChanged { mealsSelection: $mealsSelection }';
}

class Submitted extends MealScheduleEvent {
  final DateTime selectedDate;
  final MealSchedules mealsSelection;

  const Submitted({
    @required this.selectedDate,
    @required this.mealsSelection,
  });

  @override
  List<Object> get props => [selectedDate, mealsSelection];

  @override
  String toString() {
    return 'Submitted { selectedDate: $selectedDate, mealsSelection: $mealsSelection }';
  }
}
