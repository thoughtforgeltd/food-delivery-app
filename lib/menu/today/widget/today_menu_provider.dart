import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/repository/repository.dart';
import 'package:fooddeliveryapp/menu/today/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/today/widget/widget.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';

class TodayMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayMenuBloc>(
      create: (BuildContext context) => TodayMenuBloc(
          todayMenuRepository: context.repository<MenuRepository>(),
          dishRepository: context.repository<DishRepository>(),
          categoryRepository: context.repository<MealCategoryRepository>())
        ..add(TodayMenuLoadEvent()),
      child: TodayMenuWidget(),
    );
  }
}
