import 'package:equatable/equatable.dart';
import 'package:fooddeliveryapp/home/bloc/model/bottom_navigation_options.dart';
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
