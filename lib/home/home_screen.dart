import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_state.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigtion_bloc.dart';
import 'package:fooddeliveryapp/home/bottom_navigation_widget.dart';

import 'bloc/bottom_navigation_event.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc()
          ..add(BottomNavigationChanged(options: BottomNavigationState.DEFAULT_SELECTION)),
      child: BottomNavigationWidget(),
    ));
  }
}
