import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/add/bloc/bloc.dart';
import 'package:fooddeliveryapp/dish/list/bloc/bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bloc.dart';
import 'package:fooddeliveryapp/login/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/bloc.dart';
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
            configurationsRepository:
                context.repository<ConfigurationsRepository>())),
    /**
     * Menu related Blocs
     */
    BlocProvider<TodayMenuBloc>(
      create: (BuildContext context) => TodayMenuBloc(
          todayMenuRepository: context.repository<TodayMenuRepository>()),
    ),
    /**
     * User Details
     */
    BlocProvider<EditUserDetailsBloc>(
        create: (BuildContext context) => EditUserDetailsBloc(
            userDetailsRepository:
                context.repository<UserDetailsRepository>())),
  ], child: AuthenticationProvider());
}
