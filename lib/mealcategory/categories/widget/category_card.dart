import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class CategoryCard extends StatelessWidget {
  final Category _category;
  final void Function(Category) _onEditPressed;
  final void Function(Category) _onDeletePressed;

  CategoryCard(
      {Key key,
      @required Category category,
      @required Function(Category) onEditPressed,
      @required Function(Category) onDeletePressed})
      : _category = category,
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
            children: <Widget>[_buildMenuIcon(context), _buildDishDetails()],
          )),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Theme.of(context).primaryColor,
          icon: Icons.edit,
          onTap: () => _onEditPressed(_category),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).accentColor,
          icon: Icons.delete,
          onTap: () => _onDeletePressed(_category),
        ),
      ],
    ));
  }

  Widget _buildMenuIcon(BuildContext context) {
    return Container(
        padding: Dimensions.padding_4,
        child: ClipRRect(
          borderRadius: Dimensions.radius_4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: _category.image != null
              ? SvgPicture.network(_category.image,
                  height: 50, width: 50, fit: BoxFit.cover)
              : Icon(Icons.error, color: Theme.of(context).errorColor),
        ));
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
      child: Subtitle1(text: _category.title),
    );
  }

  _buildDishDescription() {
    return Container(
      margin: Dimensions.padding_4,
      child: BodyText1(text: _category.description),
    );
  }
}
