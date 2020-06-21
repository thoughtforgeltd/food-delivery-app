import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: Dimensions.padding_16,
        child: Row(
          children: <Widget>[
            _buildMealIcon(),
            Expanded(child: _buildMealTitle()),
            _buildMealAddAction(),
            _buildMealQuantity(),
            _buildMealRemoveAction()
          ],
        ),
      ),
    );
  }

  Widget _buildMealIcon() {
    return Container(
        padding: Dimensions.padding_right_16,
        child: Image.network(
            _meal.configurations.icon ?? FireStorePaths.URL_WARNING_ICON,
            color: AppColors.colorPrimary
          )
    );
  }

  Widget _buildMealTitle() {
    return Text(_meal.configurations.title);
  }

  Widget _buildMealAddAction() {
    return  IconButton(
      onPressed: () => _onAddPressed(_meal),
      icon: Icon(Icons.add),
    );
  }

  Widget _buildMealQuantity() {
    return  Text(
        _meal?.schedules?.quantity ?? "0"
    );
  }

  Widget _buildMealRemoveAction() {
    return  IconButton(
      onPressed: () => _onAddPressed(_meal),
      icon: Icon(Icons.remove),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        border: Border(
            left: BorderSide(width: 4.0, color: AppColors.colorPrimaryDark)));
  }

  void onAddPressed() {
    _onAddPressed(_meal);
  }

  void onSubtractPressed() {
    _onSubtractPressed(_meal);
  }
}
