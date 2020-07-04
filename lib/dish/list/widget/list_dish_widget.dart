import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';

import 'widget.dart';

class ListDishWidget extends StatefulWidget {
  State<ListDishWidget> createState() => _ListDishWidgetState();
}

class _ListDishWidgetState extends State<ListDishWidget> {
  ListDishBloc _listDishBloc;

  @override
  void initState() {
    _listDishBloc = BlocProvider.of<ListDishBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListDishBloc, ListDishState>(
        listener: (context, state) {
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            getAppSnackBar(
              'Error while loading Dishes..',
              Icon(Icons.error),
            ),
          );
      }
    }, child: BlocBuilder<ListDishBloc, ListDishState>(
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/addDish',
                    arguments: AddDishArguments(
                  onAddPressed: _onAddPressed
                ));
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
                          buildTodayMenu(state),
                        ]),
                  )));
      },
    ));
  }

  buildTodayMenu(ListDishState state) {
    return Column(
        children: state.dishes?.dishes
            ?.map((menu) => DishCard(
                dish: menu,
                onEditPressed: onEditDishPressed,
                onDeletePressed: onDeleteDishPressed))
            ?.toList());
  }

  void onEditDishPressed(Dish dish) {
    _listDishBloc.add(EditDishEvent(id: dish.id));
  }

  void onDeleteDishPressed(Dish dish) {
    _listDishBloc.add(DeleteDishEvent(dish: dish));
  }

  _onAddPressed(String message) {
    _listDishBloc.add(LoadDishesEvent());
  }
}
