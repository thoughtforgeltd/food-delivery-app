import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

import 'widget.dart';

class CategoriesWidget extends StatefulWidget {
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  CategoriesBloc _categoriesBloc;

  @override
  void initState() {
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            getAppSnackBar(
              'Error while loading categories..',
              Icon(Icons.error),
            ),
          );
      }
    }, child: BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/add_meal_category',
                    arguments: AddCategoryArguments(
                        onAddPressed: (e) => _onAddPressed(e)));
              },
            ),
            body: state.isLoading
                ? buildLoadingWidget()
                : SingleChildScrollView(
                    child: Container(
                    padding: Dimensions.padding_16,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          buildCategoriesList(state),
                        ]),
                  )));
      },
    ));
  }

  buildCategoriesList(CategoriesState state) {
    return Column(
        children: state.categories?.categories
            ?.map((category) => CategoryCard(
                category: category,
                onEditPressed: onEditCategoryPressed,
                onDeletePressed: onDeleteCategoryPressed))
            ?.toList());
  }

  void onEditCategoryPressed(Category category) {
    _categoriesBloc.add(EditCategoryEvent(id: category.id));
  }

  void onDeleteCategoryPressed(Category category) {
    _categoriesBloc.add(DeleteCategoryEvent(category: category));
  }

  _onAddPressed(String message) {
    _categoriesBloc.add(LoadCategoriesEvent());
  }
}
