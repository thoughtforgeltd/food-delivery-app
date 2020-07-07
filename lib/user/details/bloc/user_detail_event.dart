import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class UserDetailLoadEvent extends UserDetailEvent {}
