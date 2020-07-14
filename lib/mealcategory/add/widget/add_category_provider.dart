import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';

class AddCategoryProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Meal Category')),
      body: BlocProvider<AddCategoryBloc>(
        create: (context) => BlocProvider.of(context),
        child: AddCategoryWidget(),
      ),
    );
  }
}
