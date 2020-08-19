import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/text/subtitle1.dart';
import 'package:fooddeliveryapp/common/widget/text/text.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/model/model.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/menu/today/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/today/widget/square_dish_card.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

class TodayMenuWidget extends StatefulWidget {
  State<TodayMenuWidget> createState() => _TodayMenuWidgetState();
}

class _TodayMenuWidgetState extends State<TodayMenuWidget> {
  bool isButtonEnabled(TodayMenuState state) {
    return !state.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodayMenuBloc, TodayMenuState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'Error while loading today\'s menu',
                Icon(Icons.error),
              ),
            );
        }
      },
      child: BlocBuilder<TodayMenuBloc, TodayMenuState>(
        builder: (context, state) {
          return state.isLoading
              ? buildLoadingWidget()
              : state.isSuccess
                  ? state?.menus != null
                      ? SingleChildScrollView(
                          child: Container(
                          padding: Dimensions.padding_16,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                buildDate(state),
                                buildTodayMenu(state),
                              ]),
                        ))
                      : Center(
                          child: Subtitle1(
                              text: "There is no menu available for today"),
                        )
                  : Container();
        },
      ),
    );
  }

  buildDate(TodayMenuState state) {
    return Container(
        margin: Dimensions.padding_bottom_16,
        child: Headline4(text: state?.menus?.date?.toUIDate() ?? ""));
  }

  buildTodayMenu(TodayMenuState state) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        state?.menus?.items?.map((menu) => buildCategory(menu))?.toList() ??
            []);
  }

  Widget buildCategory(MenuItemView menuView) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCategoryTitle(menuView.category),
            buildDishCards(menuView.dishes)
          ],
        )
    );
  }

  buildCategoryTitle(Category category) {
    return Container(
      margin: Dimensions.padding_bottom_8,
      child: Headline6(text: category?.title ?? ""),
    );
  }

  buildDishCards(List<Dish> dishes) {
    return Container(
        margin: Dimensions.padding_bottom_16,
        child: new ListView.builder(
          itemCount: dishes.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SquareDishCard(dish: dishes[index]);
          },
        ));
  }
}
