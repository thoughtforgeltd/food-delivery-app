import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';

class MealCategoryIconsWidget extends StatefulWidget {
  State<MealCategoryIconsWidget> createState() =>
      _MealCategoryIconsWidgetState();
}

class _MealCategoryIconsWidgetState extends State<MealCategoryIconsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MealCategoryIconsBloc, MealCategoryIconsState>(
        listener: (context, state) {
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            getAppSnackBar(
              'Error while loading icons..',
              Icon(Icons.error),
            ),
          );
      }
    }, child: BlocBuilder<MealCategoryIconsBloc, MealCategoryIconsState>(
      builder: (context, state) {
        return state.isLoading
            ? buildLoadingWidget()
            : SingleChildScrollView(
                child: Container(
                  padding: Dimensions.padding_16,
                  child: _buildIconsList(state),
                ),
              );
      },
    ));
  }

  _buildIconsList(MealCategoryIconsState state) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: state.icons
            .map((e) => Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                    onTap: () {
                      (ModalRoute.of(context).settings.arguments
                              as SelectMealCategoryIconArgs)
                          ?.onIconSelected(e);
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: Dimensions.padding_4,
                        child: SvgPicture.network(e,
                            placeholderBuilder: (context) => Container(
                                  padding: Dimensions.padding_8,
                                  child: CircularProgressIndicator(),
                                ),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover)))))
            .toList());
  }
}
