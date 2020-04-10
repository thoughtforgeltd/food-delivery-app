import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_details_repository.dart';
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
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository, userDetailsRepository: userDetailsRepository),
    ),
  );
}


class App extends StatelessWidget {
  final UserRepository _userRepository;
  final UserDetailsRepository _userDetailsRepository;

  App({Key key, @required UserRepository userRepository,
    @required UserDetailsRepository userDetailsRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _userDetailsRepository = userDetailsRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return UserDetailsScreen(userDetailsRepository: _userDetailsRepository);
          }
          if (state is UserDetailsEntered) {
            return HomeScreen(name: state.details);
          }
        },
      ),
    );
  }
}
