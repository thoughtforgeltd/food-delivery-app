import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class CategoryCard extends StatelessWidget {
  final Category _category;
  final void Function(Category) _onSelected;

  CategoryCard(
      {Key key,
      @required Category category,
      @required Function(Category) onSelected})
      : _category = category,
        _onSelected = onSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
            onTap: () => _onSelected(_category),
            child: Container(
                padding: Dimensions.padding_8,
                child: Row(
                  children: <Widget>[_buildStartIcon(), _buildTitle()],
                ))));
  }

  Widget _buildStartIcon() {
    return Container(
        padding: Dimensions.padding_4,
        child: _category.image != null
            ? SvgPicture.network(_category.image,
                height: 25, width: 25, fit: BoxFit.cover)
            : Icon(Icons.error, color: AppColors.colorError));
  }

  Widget _buildTitle() {
    return Container(
      padding: Dimensions.padding_4,
      child: BodyText1(text: _category.title),
    );
  }
}
