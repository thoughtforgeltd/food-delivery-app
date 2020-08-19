import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/bloc.dart';
import 'package:fooddeliveryapp/console/console.dart';
import 'package:fooddeliveryapp/dish/add/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bloc.dart';
import 'package:fooddeliveryapp/login/bloc/bloc.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/register/bloc/bloc.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

import '../main.dart';

getBlocsProvider() {
  return MultiBlocProvider(providers: [
    /**
     * Authentication related blocs
     */
    BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(
          userRepository: context.repository<UserRepository>(),
          userDetailsRepository: context.repository<UserDetailsRepository>()),
    ),
    BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(
        userRepository: context.repository<UserRepository>(),
      ),
    ),
    BlocProvider<RegisterBloc>(
        create: (BuildContext context) =>
            RegisterBloc(userRepository: context.repository<UserRepository>())),
    /**
     * Dish related Blocs
     */
    BlocProvider<ListDishBloc>(
      create: (BuildContext context) =>
          ListDishBloc(dishRepository: context.repository<DishRepository>()),
    ),
    BlocProvider<AddDishBloc>(
      create: (BuildContext context) =>
          AddDishBloc(dishRepository: context.repository<DishRepository>()),
    ),
    /**
     * Bottom Navigation related Blocs
     */
    BlocProvider<BottomNavigationBloc>(
      create: (BuildContext context) => BottomNavigationBloc(),
    ),
    /**
     * Meal related Blocs
     */
    BlocProvider<MealScheduleBloc>(
        create: (BuildContext context) => MealScheduleBloc(
            userRepository: context.repository<UserRepository>(),
            mealScheduleRepository:
                context.repository<MealScheduleRepository>(),
            categoriesRepository:
                context.repository<MealCategoryRepository>())),
    /**
     * Menu related Blocs
     */
    BlocProvider<ScheduleMenuBloc>(
      create: (BuildContext context) => ScheduleMenuBloc(
          todayMenuRepository: context.repository<MenuRepository>(),
          categoryRepository: context.repository<MealCategoryRepository>(),
          dishRepository: context.repository<DishRepository>()),
    ),
    /**
     * User Details
     */
    BlocProvider<EditUserDetailsBloc>(
        create: (BuildContext context) => EditUserDetailsBloc(
            userDetailsRepository:
                context.repository<UserDetailsRepository>())),
    /**
     * Console
     */
    BlocProvider<ConsoleBloc>(create: (BuildContext context) => ConsoleBloc()),
    BlocProvider<MealCategoryIconsBloc>(
        create: (BuildContext context) => MealCategoryIconsBloc(
            iconsRepository: context.repository<MealCategoryRepository>())),
    BlocProvider<AddCategoryBloc>(
        create: (BuildContext context) => AddCategoryBloc(
            categoryRepository: context.repository<MealCategoryRepository>())),
    BlocProvider<CategoriesBloc>(
        create: (BuildContext context) => CategoriesBloc(
            categoryRepository: context.repository<MealCategoryRepository>())),
  ], child: AuthenticationProvider());
}
