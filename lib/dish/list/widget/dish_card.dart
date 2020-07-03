import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/menu/model/menu.dart';
import 'package:fooddeliveryapp/repositories/paths/firebase_congiguration_paths.dart';

class DishCard extends StatelessWidget {
  final Dish _dish;

  DishCard({Key key, Dish dish})
      : _dish = dish,
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
          children: <Widget>[_buildMenuIcon(), _buildMenuTitle()],
        ),
      ),
    );
  }

  Widget _buildMenuIcon() {
    return Container(
        padding: Dimensions.padding_right_16,
        child: _dish.image != null
            ? Image.network(_dish.image,
                height: 100, width: 100, fit: BoxFit.cover)
            : Container());
  }

  Widget _buildMenuTitle() {
    return Expanded(child: Text(_dish.title));
  }
}
