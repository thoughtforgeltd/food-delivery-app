import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/bloc.dart';
import 'package:fooddeliveryapp/user/details/bloc/bloc.dart';
import 'package:fooddeliveryapp/user/details/widget/widget.dart';

class UserDetailsScreen extends StatelessWidget {
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
        child: BlocProvider<UserDetailsBloc>(
          create: (context) => BlocProvider.of(context),
          child: UserDetailsForm(),
        ),
      ),
    );
  }
}
