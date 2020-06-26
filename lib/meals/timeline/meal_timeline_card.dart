import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/design/text_styles.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/repositories/paths/firebase_congiguration_paths.dart';

class MealTimelineCard extends StatelessWidget {
  final void Function(MealSelection) _onAddPressed;
  final void Function(MealSelection) _onSubtractPressed;
  final MealSelection _meal;

  MealTimelineCard(
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
            _buildMealTitle(),
            _buildMealQuantity(),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTitle() {
    return Expanded(child: Text(_meal.configurations.title));
  }

  Widget _buildMealIcon() {
    return Container(
        padding: Dimensions.padding_right_16,
        child: SvgPicture.network(
            _meal.configurations.icon ?? FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color: AppColors.colorPrimary));
  }

  Widget _buildMealQuantity() {
    return Text(
      _meal?.schedules?.quantity?.toString() ?? "0",
      style: TextStyles.bold,
    );
  }

  Function onSubtractPressed() {
    if (_meal?.schedules?.quantity == 0)
      return null;
    else
      return () => _onSubtractPressed(_meal);
  }

  void onAddPressed() {
    _onAddPressed(_meal);
  }
}
