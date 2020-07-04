import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';

class DishCard extends StatelessWidget {
  final Dish _dish;
  final void Function(Dish) _onEditPressed;
  final void Function(Dish) _onDeletePressed;

  DishCard(
      {Key key,
      @required Dish dish,
      @required Function(Dish) onEditPressed,
      @required Function(Dish) onDeletePressed})
      : _dish = dish,
        _onEditPressed = onEditPressed,
        _onDeletePressed = onDeletePressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: <Widget>[_buildMenuIcon(), _buildDishDetails()],
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: AppColors.colorPrimary,
          icon: Icons.edit,
          onTap: () => _onEditPressed(_dish),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: AppColors.colorPrimaryAccent,
          icon: Icons.delete,
          onTap: () => _onDeletePressed(_dish),
        ),
      ],
    ));
  }

  Widget _buildMenuIcon() {
    return Container(
      padding: Dimensions.padding_4,
      child: ClipRRect(
        borderRadius: Dimensions.radius_4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: _dish.image != null
            ? Image.network(_dish.image, height: 80, width: 80, fit: BoxFit.cover)
            : Icon(Icons.error, color: AppColors.colorError),
      )
    );
  }

  Widget _buildDishDetails() {
    return Expanded(
        child: Container(
            padding: Dimensions.padding_left_8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_buildDishTitle(), _buildDishDescription()],
            )));
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
