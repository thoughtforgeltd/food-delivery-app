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
  final void Function(MealSelection) _onMealSchedulePressed;
  final MealSelection _meal;
  final bool _disabled;

  MealTimelineCard(
      {Key key,
      bool disabled,
      Function(MealSelection) onMealSchedulePressed,
      MealSelection meal})
      : _onMealSchedulePressed = onMealSchedulePressed,
        _disabled  = disabled,
        _meal = meal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: Dimensions.radius,
      ),
      child: new InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: Dimensions.radius,
        ),
        onTap: _disabled ? () => onMealSchedulePressed() : null,
        child: Container(
          margin: Dimensions.padding_16,
          child: Row(
            children: <Widget>[
              _buildMealIcon(),
              _buildMealTitle(),
              _buildMealQuantity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealTitle() {
    return Expanded(child: Text(_meal.configurations.title,
        style: _disabled ? TextStyles.regular : TextStyles.regularDisabled));
  }

  Widget _buildMealIcon() {
    return Container(
        margin: Dimensions.padding_right_16,
        child: SvgPicture.network(
            _meal.configurations.icon ?? FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color: _disabled ? AppColors.colorPrimary :  AppColors.colorDisable));
  }

  Widget _buildMealQuantity() {
    return Text(
      _meal?.schedules?.quantity?.toString() ?? "0",
      style: _disabled ? TextStyles.bold : TextStyles.disabledBold);
  }

  void onMealSchedulePressed() {
    _onMealSchedulePressed(_meal);
  }
}
