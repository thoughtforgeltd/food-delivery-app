import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends UserDetailsEvent {
  final String firstName;

  const FirstNameChanged({@required this.firstName});

  @override
  List<Object> get props => [firstName];

  @override
  String toString() => 'FirstNameChanged { firstName :$firstName }';
}

class LastNameChanged extends UserDetailsEvent {
  final String lastName;

  const LastNameChanged({@required this.lastName});

  @override
  List<Object> get props => [lastName];

  @override
  String toString() => 'LastNameChanged { lastName :$lastName }';
}

class AddressChanged extends UserDetailsEvent {
  final String address;

  const AddressChanged({@required this.address});

  @override
  List<Object> get props => [PointerChange.add];

  @override
  String toString() => 'AddressChanged { address: $address }';
}

class PhoneChanged extends UserDetailsEvent {
  final String phone;

  const PhoneChanged({@required this.phone});

  @override
  List<Object> get props => [PointerChange.add];

  @override
  String toString() => 'PhoneChanged { phone: $phone }';
}

class Submitted extends UserDetailsEvent {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;

  const Submitted({
    @required this.firstName,
    @required this.lastName,
    @required this.address,
    @required this.phone,
  });

  @override
  List<Object> get props => [firstName, lastName, address, phone];

  @override
  String toString() {
    return 'Submitted { firstName: $firstName, lastName: $lastName, address: $address, phone: $phone}';
  }
}
