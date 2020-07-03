import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';

import 'widget.dart';

class ListDishWidget extends StatefulWidget {
  State<ListDishWidget> createState() => _ListDishWidgetState();
}

class _ListDishWidgetState extends State<ListDishWidget> {
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
      },
      child: BlocBuilder<ListDishBloc, ListDishState>(
        builder: (context, state) {
          return state.isLoading
              ? buildLoadingWidget()
              : SingleChildScrollView(
                  child: Container(
                  padding: Dimensions.padding_16,
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    buildTodayMenu(state),
                  ]),
                ));
        },
      ),
    );
  }

  buildTodayMenu(ListDishState state) {
    return Column(
        children: state.dishes?.dishes
            ?.map((menu) => DishCard(dish: menu))
            ?.toList());
  }
}
