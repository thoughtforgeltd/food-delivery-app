import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';

class SquareDishCard extends StatelessWidget {
  final Dish _dish;

  SquareDishCard({Key key, @required Dish dish})
      : _dish = dish,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: <Widget>[
          _buildMenuIcon(context),
          Expanded(child: _buildDishDetails())
        ],
      ),
    ));
  }

  Widget _buildMenuIcon(BuildContext context) {
    return Container(
        padding: Dimensions.padding_4,
        child: ClipRRect(
          borderRadius: Dimensions.radius,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: _dish.image != null
              ? Image.network(_dish.image,
                  height: 80, width: 80, fit: BoxFit.cover)
              : Icon(Icons.error, color: Theme.of(context).errorColor),
        ));
  }

  Widget _buildDishDetails() {
    return Container(
        padding: Dimensions.padding_left_8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_buildDishTitle(), _buildDishDescription()],
        ));
  }

  _buildDishTitle() {
    return Container(
      margin: Dimensions.padding_4,
      child: Subtitle1(text: _dish.title),
    );
  }

  _buildDishDescription() {
    return Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _dish.description),
    );
  }
}
