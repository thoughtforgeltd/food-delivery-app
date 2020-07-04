import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/widget/widget.dart';

class TodayMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayMenuBloc>(
      create: (context) => BlocProvider.of(context)..add(TodayMenuLoadEvent()),
      child: TodayMenuWidget(),
    );
  }
}

