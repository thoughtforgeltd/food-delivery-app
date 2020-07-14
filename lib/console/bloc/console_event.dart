import 'package:equatable/equatable.dart';

abstract class ConsoleEvent extends Equatable {
  const ConsoleEvent();

  @override
  List<Object> get props => [];
}

class LoadConsoleActionsEvent extends ConsoleEvent {}
