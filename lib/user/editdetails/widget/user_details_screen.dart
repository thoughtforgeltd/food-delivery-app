import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/bloc.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class EditUserDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
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
        child: BlocProvider<EditUserDetailsBloc>(
          create: (context) => BlocProvider.of(context),
          child: EditUserDetailsForm(),
        ),
      ),
    );
  }
}
