import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class MealCategoryIconsProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Icon"),
        ),
        body: BlocProvider<MealCategoryIconsBloc>(
          create: (context) =>
              BlocProvider.of(context)..add(LoadMealCategoryIconsEvent()),
          child: MealCategoryIconsWidget(),
        ));
  }
}
