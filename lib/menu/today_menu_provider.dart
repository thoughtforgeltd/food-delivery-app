import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_event.dart';
import 'package:fooddeliveryapp/menu/today_menu_widget.dart';
import 'package:fooddeliveryapp/repositories/today_menu_repository.dart';

class TodayMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodayMenuBloc>(
      create: (context) => TodayMenuBloc(
          todayMenuRepository: context.repository<TodayMenuRepository>())
        ..add(TodayMenuLoadEvent()),
      child: TodayMenuWidget(),
    );
  }
}

