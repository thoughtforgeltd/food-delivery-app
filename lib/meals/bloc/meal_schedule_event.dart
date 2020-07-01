import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:meta/meta.dart';

abstract class MealScheduleEvent extends Equatable {
  const MealScheduleEvent();

  @override
  List<Object> get props => [];
}

class MealSchedulesLoaded extends MealScheduleEvent {}

class DateChanged extends MealScheduleEvent {
  final Timestamp selectedDate;

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
  String toString() =>
      'MealSelectionChanged { mealsSelection: $mealsSelection }';
}

class AddMealSchedule extends MealScheduleEvent {
  final MealSelection selection;

  const AddMealSchedule({
    @required this.selection,
  });

  @override
  List<Object> get props => [selection];

  @override
  String toString() {
    return 'AddMealSchedule { selection: $selection}';
  }
}

class RemoveMealSchedule extends MealScheduleEvent {
  final MealSelection selection;

  const RemoveMealSchedule({
    @required this.selection,
  });

  @override
  List<Object> get props => [selection];

  @override
  String toString() {
    return 'RemoveMealSchedule { selection: $selection}';
  }
}

class Submitted extends MealScheduleEvent {
  final DateTime selectedDate;
  final MealSchedules mealsSelection;
  final bool handleSubmitted;

  const Submitted({
    @required this.selectedDate,
    @required this.mealsSelection,
    @required this.handleSubmitted,
  });

  @override
  List<Object> get props => [selectedDate, mealsSelection, handleSubmitted];

  @override
  String toString() {
    return 'Submitted { selectedDate: $selectedDate, mealsSelection: $mealsSelection handleSubmitted:$handleSubmitted }';
  }
}
