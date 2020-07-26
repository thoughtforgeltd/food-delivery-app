import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';
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

class MenuSelectionChanged extends ScheduleMenuEvent {
  final Menus menus;

  const MenuSelectionChanged({@required this.menus});

  @override
  List<Object> get props => [menus];

  @override
  String toString() => 'MenuSelectionChanged { menus: $menus }';
}

class AddMenuSchedule extends ScheduleMenuEvent {
  final MenuView menus;

  const AddMenuSchedule({
    @required this.menus,
  });

  @override
  List<Object> get props => [menus];

  @override
  String toString() {
    return 'AddMenuSchedule { menus: $menus}';
  }
}

class RemoveMenuSchedule extends ScheduleMenuEvent {
  final MenuView menus;

  const RemoveMenuSchedule({
    @required this.menus,
  });

  @override
  List<Object> get props => [menus];

  @override
  String toString() {
    return 'RemoveMenuSchedule { menus: $menus}';
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
