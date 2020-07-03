import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/design/themes.dart';
import 'package:fooddeliveryapp/repositories/configuration_repository.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/repositories/today_menu_repository.dart';
import 'package:fooddeliveryapp/splash_screen.dart';
import 'package:fooddeliveryapp/userdetails/user_details_screen.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/bloc/authentication_event.dart';
import 'authentication/bloc/authentication_state.dart';
import 'authentication/repository/user_repository.dart';
import 'common/blog_delegate.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(getRepositoryProvider());
}

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
  ], child: AuthenticationProvider());
}

class AuthenticationProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          userRepository: context.repository<UserRepository>(),
          userDetailsRepository: context.repository<UserDetailsRepository>())
        ..add(AppStarted()),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
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
            return UserDetailsScreen();
          }
          if (state is UserDetailsEntered) {
            return HomeScreen(name: state.details);
          }
        },
      ),
    );
  }
}
