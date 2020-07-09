import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/console/console.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class ConsoleWidget extends StatefulWidget {
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsoleBloc, ConsoleState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[_buildActionsList(state)],
          ),
        );
      },
    );
  }

  _buildActionsList(ConsoleState state) {
    return Column(
        children: state.actions
            ?.map((action) =>
                ConsoleActionCard(action: action, onPressed: onActionPressed))
            ?.toList());
  }

  onActionPressed(ConsoleActions action) {
    switch (action) {
      case ConsoleActions.dishes:
        Navigator.of(context).pushNamed('/dishes');
        break;
      case ConsoleActions.add_dish:
        Navigator.of(context).pushNamed('/add_dish');
        break;
      case ConsoleActions.meal_types:
        Navigator.of(context).pushNamed('/select_meal_category_icon',
            arguments: SelectMealCategoryIconArgs(
                onIconSelected: (e) => Scaffold.of(context)
                  ..showSnackBar(getAppSnackBar(
                    e,
                    Icon(Icons.error),
                  ))));
        break;
    }
  }
}
