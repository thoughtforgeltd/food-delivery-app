import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_event.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/userdetails/bloc/user_details_bloc.dart';
import 'package:fooddeliveryapp/userdetails/user_details_form.dart';

class UserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],),
      body: Center(
        child: BlocProvider<UserDetailsBloc>(
          create: (context) => UserDetailsBloc(userDetailsRepository: context.repository<UserDetailsRepository>(),
          userRepository: context.repository<UserRepository>()),
          child: UserDetailsForm(),
        ),
      ),
    );
  }
}
