import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/dish/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/widget/widget.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';

class AddDishProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dish')),
      body: BlocProvider<DishBloc>(
        create: (context) => DishBloc(dishRepository: context.repository<DishRepository>()),
        child: AddDishWidget(),
      ),
    );
  }
}
