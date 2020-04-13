import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/repositories/paths/firebase_congiguration_paths.dart';

class MealSelectionCard extends StatelessWidget {
  final void Function(MealSelection) _onAddPressed;
  final void Function(MealSelection) _onSubtractPressed;
  final MealSelection _meal;

  MealSelectionCard(
      {Key key,
      Function(MealSelection) onAddPressed,
      Function(MealSelection) onSubtractPressed,
      MealSelection meal})
      : _onAddPressed = onAddPressed,
        _onSubtractPressed = onSubtractPressed,
        _meal = meal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
            border: Border(
                left:
                    BorderSide(width: 4.0, color: AppColors.colorPrimaryDark))),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Image.network(
                          _meal.configurations.icon  ?? FireStorePaths.URL_WARNING_ICON,
                          color: AppColors.colorPrimary,
                          scale: 2,
                        )
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
