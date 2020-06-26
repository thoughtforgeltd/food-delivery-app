import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/home/bloc/model/bottom_navigation_options.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BottomNavigationChanged extends BottomNavigationEvent {
  final BottomNavigationOptions options;

  const BottomNavigationChanged({@required this.options});

  @override
  List<Object> get props => [options];

  @override
  String toString() => 'BottomNavigationChanged { options :$options }';
}
