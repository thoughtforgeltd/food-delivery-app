import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bloc.dart';
import 'package:fooddeliveryapp/home/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider<BottomNavigationBloc>(
      create: (context) => BlocProvider.of(context)
        ..add(BottomNavigationChanged(
            options: BottomNavigationState.DEFAULT_SELECTION)),
      child: BottomNavigationWidget(),
    ));
  }
}
