import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_bloc.dart';
import 'package:fooddeliveryapp/userdetails/user_details_form.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsRepository _userDetailsRepository;

  UserDetailsScreen({Key key, @required UserDetailsRepository userDetailsRepository})
      : assert(userDetailsRepository != null),
        _userDetailsRepository = userDetailsRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Center(
        child: BlocProvider<UserDetailsBloc>(
          create: (context) => UserDetailsBloc(userDetailsRepository: _userDetailsRepository),
          child: UserDetailsForm(),
        ),
      ),
    );
  }
}
