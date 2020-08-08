import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/console/console.dart';
import 'package:fooddeliveryapp/design/themes.dart';
import 'package:fooddeliveryapp/dish/list/widget/list_dish_provider.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/meals/schedule/update_meal_schedule_screen.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

import 'authentication/bloc/bloc.dart';
import 'common/blog_delegate.dart';
import 'di/di.dart';
import 'dish/add/widget/widget.dart';
import 'home/widget/home_screen.dart';
import 'login/widget/login_screen.dart';
import 'mealcategory/add/add_category_alias.dart';
import 'splash/widget/widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(getRepositoryProvider());
}

class AuthenticationProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BlocProvider.of<AuthenticationBloc>(context)..add(AppStarted()),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      routes: {
        '/addDish': (context) => AddDishProvider(),
        '/update_meals': (context) => UpdateMealScheduleScreen(),
        '/console': (context) => ConsoleProvider(),
        '/dishes': (context) => ListDishProvider(),
        '/categories': (context) => CategoriesProvider(),
        '/add_dish': (context) => AddDishProvider(),
        '/add_meal_category': (context) => AddCategoryProvider(),
        '/select_meal_category_icon': (context) => MealCategoryIconsProvider(),
        '/schedule_menu': (context) => ScheduleMenuProvider(),
        '/edit_profile': (context) => EditUserDetailsScreen(),
      },
      theme: MealDeliveryThemes.lightTheme,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen();
          }
          if (state is Authenticated) {
            return EditUserDetailsScreen();
          }
          if (state is UserDetailsEntered) {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
