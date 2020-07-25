import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/common.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/menu/model/model.dart';

class TodayMenuCard extends StatelessWidget {
  final Menu _menu;

  TodayMenuCard({Key key, Menu menu})
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
          children: <Widget>[
            _buildMenuIcon(),
            _buildMenuTitle()
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon() {
    return Container(
        padding: Dimensions.padding_right_16,
        child: SvgPicture.network(
//            _menu.item.icon ??
            FireStorePaths.URL_WARNING_ICON,
            height: Sizes.icon_size,
            color: AppColors.colorPrimary));
  }

  Widget _buildMenuTitle() {
    return Expanded(child: Text("Menu"));
  }
}
