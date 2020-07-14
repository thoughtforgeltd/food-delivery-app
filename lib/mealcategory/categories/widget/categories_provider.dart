import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class CategoriesProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meal Categories"),
        ),
        body: BlocProvider<CategoriesBloc>(
          create: (context) =>
              BlocProvider.of(context)..add(LoadCategoriesEvent()),
          child: CategoriesWidget(),
        ));
  }
}
