import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_event.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_bloc.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_event.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_state.dart';
import 'package:fooddeliveryapp/userdetails/user_details_button.dart';

class UserDetailsForm extends StatefulWidget {
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  UserDetailsBloc _userDetailsBloc;

  bool get isPopulated =>
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _addressController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty;

  bool isButtonEnabled(UserDetailsState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    _firstNameController.addListener(_onFirstNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _addressController.addListener(_onAddressChanged);
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Updating User Details...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(AddedUserDetails());
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('There is an error while updating user details..'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'First Name',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isFirstNameValid ? 'First Name can not be empty' : null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Last Name',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isLastNameValid ? 'Last Name can not be empty' : null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city),
                      labelText: 'Address',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isAddressValid ? 'Address can not be empty' : null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Phone',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isLastNameValid ? 'Phone can not be empty' : null;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.all(10)
                  ),
                  UserDetailsButton(
                    onPressed: isButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onFirstNameChanged() {
    _userDetailsBloc.add(
      FirstNameChanged(firstName: _firstNameController.text),
    );
  }

  void _onLastNameChanged() {
    _userDetailsBloc.add(
      LastNameChanged(lastName: _lastNameController.text),
    );
  }

  void _onAddressChanged() {
    _userDetailsBloc.add(
      AddressChanged(address: _addressController.text),
    );
  }

  void _onPhoneChanged() {
    _userDetailsBloc.add(
      PhoneChanged(phone: _phoneController.text),
    );
  }

  void _onFormSubmitted() {
    _userDetailsBloc.add(
      Submitted(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
      ),
    );
  }
}
