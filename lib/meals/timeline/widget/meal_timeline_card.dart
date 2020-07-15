import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/design/text_styles.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';

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
        _disabled = disabled,
        _meal = meal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: Dimensions.radius_4,
        ),
        onTap: _disabled ? null : () => onMealSchedulePressed(),
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
    return Expanded(
        child: Text(_meal.category.title,
            style:
                _disabled ? TextStyles.regularDisabled : TextStyles.regular));
  }

  Widget _buildMealIcon() {
    return Container(
        margin: Dimensions.padding_right_16,
        child: SvgPicture.network(
            _meal.category.image ?? FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color:
            _disabled ? AppColors.colorDisable : AppColors.colorPrimary));
  }

  Widget _buildMealQuantity() {
    return Text(_meal?.schedules?.quantity?.toString() ?? "0",
        style: _disabled ? TextStyles.disabledBold : TextStyles.bold);
  }

  void onMealSchedulePressed() {
    _onMealSchedulePressed(_meal);
  }
}
