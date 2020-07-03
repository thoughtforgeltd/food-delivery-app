import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/register/register_form.dart';

import 'bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: context.repository<UserRepository>()),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
