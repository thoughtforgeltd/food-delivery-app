import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';

import 'di.dart';

getRepositoryProvider() {
  return MultiRepositoryProvider(providers: [
    RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(),
    ),
    RepositoryProvider<UserDetailsRepository>(
      create: (context) => UserDetailsRepository(),
    ),
    RepositoryProvider<MealScheduleRepository>(
      create: (context) => MealScheduleRepository(),
    ),
    RepositoryProvider<ConfigurationsRepository>(
      create: (context) => ConfigurationsRepository(),
    ),
    RepositoryProvider<TodayMenuRepository>(
      create: (context) => TodayMenuRepository(),
    ),
    RepositoryProvider<DishRepository>(
      create: (context) => DishRepository(),
    ),
  ], child: getBlocsProvider());
}