import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/list/widget/widget.dart';

class ListDishProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dishes"),
        ),
        body: BlocProvider<ListDishBloc>(
          create: (context) => BlocProvider.of(context)..add(LoadDishesEvent()),
          child: ListDishWidget(),
        ));
  }
}
