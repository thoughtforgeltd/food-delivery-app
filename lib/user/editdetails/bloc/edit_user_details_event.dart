import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EditUserDetailsEvent extends Equatable {
  const EditUserDetailsEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends EditUserDetailsEvent {
  final String firstName;

  const FirstNameChanged({@required this.firstName});

  @override
  List<Object> get props => [firstName];

  @override
  String toString() => 'FirstNameChanged { firstName :$firstName }';
}

class LastNameChanged extends EditUserDetailsEvent {
  final String lastName;

  const LastNameChanged({@required this.lastName});

  @override
  List<Object> get props => [lastName];

  @override
  String toString() => 'LastNameChanged { lastName :$lastName }';
}

class AddressChanged extends EditUserDetailsEvent {
  final String address;

  const AddressChanged({@required this.address});

  @override
  List<Object> get props => [PointerChange.add];

  @override
  String toString() => 'AddressChanged { address: $address }';
}

class PhoneChanged extends EditUserDetailsEvent {
  final String phone;

  const PhoneChanged({@required this.phone});

  @override
  List<Object> get props => [PointerChange.add];

  @override
  String toString() => 'PhoneChanged { phone: $phone }';
}

class ProfileImageAddedEvent extends EditUserDetailsEvent {
  final String path;

  const ProfileImageAddedEvent({@required this.path});

  @override
  List<Object> get props => [path];

  @override
  String toString() => 'PhoneChanged { path: $path }';
}

class Submitted extends EditUserDetailsEvent {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  final String path;

  const Submitted({
    @required this.firstName,
    @required this.lastName,
    @required this.address,
    @required this.phone,
    @required this.path,
  });

  @override
  List<Object> get props => [firstName, lastName, address, phone, path];

  @override
  String toString() {
    return 'Submitted { firstName: $firstName, lastName: $lastName, address: $address, phone: $phone, path: $path}';
  }
}
