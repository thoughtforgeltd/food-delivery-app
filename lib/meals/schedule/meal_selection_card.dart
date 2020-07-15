import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';

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
        padding: Dimensions.padding_8,
        child: Row(
          children: <Widget>[
            _buildMealIcon(),
            _buildMealTitle(),
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
        child: SvgPicture.network(
            _meal.category.image ?? FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color: AppColors.colorPrimary));
  }

  Widget _buildMealTitle() {
    return Expanded(child: Text(_meal.category.title));
  }

  Widget _buildMealAddAction() {
    return IconButton(
      onPressed: () => onAddPressed(),
      icon: Icon(Icons.add),
    );
  }

  Widget _buildMealQuantity() {
    return Text(_meal?.schedules?.quantity?.toString() ?? "0");
  }

  Widget _buildMealRemoveAction() {
    return IconButton(
      onPressed: onSubtractPressed(),
      icon: Icon(Icons.remove),
    );
  }

  Function onSubtractPressed() {
    if(_meal?.schedules?.quantity == 0)
      return null;
    else return () => _onSubtractPressed(_meal);
  }

  void onAddPressed() {
    _onAddPressed(_meal);
  }
}
