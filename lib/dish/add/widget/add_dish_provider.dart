import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/dish/add/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/add/widget/widget.dart';

class AddDishProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Dish')),
      body: BlocProvider<AddDishBloc>(
        create: (context) => BlocProvider.of(context),
        child: AddDishWidget(),
      ),
    );
  }
}
