import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/menu/model/menus.dart';
import 'package:meta/meta.dart';

abstract class TodayMenuEvent extends Equatable {
  const TodayMenuEvent();

  @override
  List<Object> get props => [];
}

class TodayMenuLoadEvent extends TodayMenuEvent {}

class TodayMenuLoadedEvent extends TodayMenuEvent {
  final Menus menus;

  const TodayMenuLoadedEvent({@required this.menus});

  @override
  List<Object> get props => [menus];

  @override
  String toString() => 'TodayMenuLoadedEvent { menus :$menus }';
}
