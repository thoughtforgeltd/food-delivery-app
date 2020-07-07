import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/bloc.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'widget.dart';

class EditUserDetailsForm extends StatefulWidget {
  State<EditUserDetailsForm> createState() => _EditUserDetailsFormState();
}

class _EditUserDetailsFormState extends State<EditUserDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  EditUserDetailsBloc _userDetailsBloc;

  bool get isPopulated =>
      _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _addressController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty;

  bool isButtonEnabled(EditUserDetailsState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _userDetailsBloc = BlocProvider.of<EditUserDetailsBloc>(context);
    _firstNameController.addListener(_onFirstNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _addressController.addListener(_onAddressChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditUserDetailsBloc, EditUserDetailsState>(
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
      child: BlocBuilder<EditUserDetailsBloc, EditUserDetailsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () => _onAddImagePressed(state.imagePath),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: state.imagePath == null
                            ? Icon(Icons.add_a_photo, size: 50)
                            : SizedBox(
                                width: 250,
                                height: 250,
                                child: Image.file(File(state.imagePath),
                                    fit: BoxFit.cover)),
                      ),
                    ),
                  ),
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
                      return !state.isFirstNameValid
                          ? 'First Name can not be empty'
                          : null;
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
                      return !state.isLastNameValid
                          ? 'Last Name can not be empty'
                          : null;
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
                      return !state.isAddressValid
                          ? 'Address can not be empty'
                          : null;
                    },
                  ),
                  InternationalPhoneNumberInput(
                    selectorTextStyle: Theme.of(context).textTheme.bodyText1,
                    inputDecoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    textFieldController: _phoneController,
                    maxLength: 11,
                    onInputChanged: _onPhoneChanged,
                    initialValue: PhoneNumber(
                        phoneNumber: "", dialCode: "+44", isoCode: "GB"),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  EditUserDetailsButton(
                    onPressed: isButtonEnabled(state)
                        ? () => _onFormSubmitted(state)
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

  void _onPhoneChanged(PhoneNumber number) {
    _userDetailsBloc.add(
      PhoneChanged(phone: number.toString()),
    );
  }

  void _onAddImagePressed(String path) {
    _userDetailsBloc.add(
      ProfileImageAddedEvent(path: path),
    );
  }

  void _onFormSubmitted(EditUserDetailsState state) {
    _userDetailsBloc.add(
      Submitted(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          address: _addressController.text,
          phone: state.phone,
          path: state.imagePath
      ),
    );
  }
}
