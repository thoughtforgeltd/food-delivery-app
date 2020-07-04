import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/login/bloc/bloc.dart';
import 'package:fooddeliveryapp/login/widget/widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => BlocProvider.of(context),
        child: LoginForm(),
      ),
    );
  }
}
