import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
import 'package:fooddeliveryapp/design/themes.dart';
import 'package:fooddeliveryapp/repositories/configuration_repository.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';
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
  final UserRepository userRepository = UserRepository();
  final UserDetailsRepository userDetailsRepository = UserDetailsRepository();
  final MealScheduleRepository mealScheduleRepository =
  MealScheduleRepository();
  runApp(
      MultiRepositoryProvider(
          providers: [
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
          ],
          child: BlocProvider(
            create: (context) =>
            AuthenticationBloc(
                userRepository: userRepository,
                userDetailsRepository: userDetailsRepository)
              ..add(AppStarted()),
            child: App(
                userRepository: userRepository,
                userDetailsRepository: userDetailsRepository,
                mealScheduleRepository: mealScheduleRepository),
          ),
      )
  );
}


class App extends StatelessWidget {
  final UserRepository _userRepository;
  final UserDetailsRepository _userDetailsRepository;

  App({Key key,
    @required UserRepository userRepository,
    @required MealScheduleRepository mealScheduleRepository,
    @required UserDetailsRepository userDetailsRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _userDetailsRepository = userDetailsRepository,
        super(key: key);

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
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return UserDetailsScreen(
                userDetailsRepository: _userDetailsRepository,
                userRepository: _userRepository);
          }
          if (state is UserDetailsEntered) {
            return HomeScreen(name: state.details);
          }
        },
      ),
    );
  }
}
