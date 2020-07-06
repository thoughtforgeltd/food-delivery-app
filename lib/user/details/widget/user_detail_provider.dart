import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

class UserDetailProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailBloc>(
      create: (context) => BlocProvider.of(context)..add(UserDetailLoadEvent()),
      child: UserDetailWidget(),
    );
  }
}
