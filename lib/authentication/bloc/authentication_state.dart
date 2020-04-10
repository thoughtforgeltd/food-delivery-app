import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class UserDetailsEntered extends AuthenticationState {
  final String details;

  const UserDetailsEntered(this.details);

  @override
  List<Object> get props => [details];

  @override
  String toString() => 'UserDetailsEntered { displayName: $details }';
}

class Unauthenticated extends AuthenticationState {}
