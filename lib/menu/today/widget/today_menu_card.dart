import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/dish/list/widget/widget.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';

class TodayMenuCard extends StatelessWidget {
  final MenuItemView _menu;

  TodayMenuCard({Key key, MenuItemView menu})
      : _menu = menu,
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
          children: <Widget>[_buildMenuIcon(context), _buildMenuTitle()],
        ),
      ),
    );
  }

  Widget _buildMenuIcon(BuildContext context) {
    return Container(
        padding: Dimensions.padding_right_16,
        child: SvgPicture.network(
//            _menu.item.icon ??
            FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color: Theme
                .of(context)
                .primaryColor));
  }

  Widget _buildMenuTitle() {
    return Expanded(
        child: Column(
      children: [Text(_menu.category?.title ?? ""), buildDishes()],
    ));
  }

  buildDishes() {
    return Column(
        children: _menu?.dishes
            ?.map((dish) => DishCard(
                dish: dish, onEditPressed: null, onDeletePressed: null))
            ?.toList());
  }
}
