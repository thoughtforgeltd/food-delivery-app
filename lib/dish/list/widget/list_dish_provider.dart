import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/list/widget/widget.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';

class ListDishProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListDishBloc>(
      create: (context) => ListDishBloc(
          dishRepository: context.repository<DishRepository>())
        ..add(LoadDishesEvent()),
      child: ListDishWidget(),
    );
  }
}

