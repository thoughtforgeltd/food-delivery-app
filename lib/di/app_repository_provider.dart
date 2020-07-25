import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/user/user_details_alias.dart';

import 'di.dart';

getRepositoryProvider() {
  return MultiRepositoryProvider(providers: [
    RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(),
    ),
    RepositoryProvider<UserDetailsRepository>(
      create: (context) =>
          UserDetailsRepository(userRepository: RepositoryProvider.of(context)),
    ),
    RepositoryProvider<MealScheduleRepository>(
      create: (context) => MealScheduleRepository(),
    ),
    RepositoryProvider<MenuRepository>(
      create: (context) => MenuRepository(),
    ),
    RepositoryProvider<DishRepository>(
      create: (context) => DishRepository(),
    ),
    RepositoryProvider<MealCategoryRepository>(
      create: (context) => MealCategoryRepository(),
    ),
  ], child: getBlocsProvider());
}
