import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';

import '../add_schedule.dart';

class ScheduleMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Menu')),
      body: BlocProvider<ScheduleMenuBloc>(
        create: (context) => ScheduleMenuBloc(
            todayMenuRepository: context.repository<MenuRepository>(),
            categoryRepository: context.repository<MealCategoryRepository>(),
            dishRepository: context.repository<DishRepository>())
          ..add(MenuSchedulesLoaded()),
        child: ScheduleMenuWidget(),
      ),
    );
  }
}
