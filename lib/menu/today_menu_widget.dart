import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_bloc.dart';
import 'package:fooddeliveryapp/menu/bloc/today_menu_state.dart';

class TodayMenuWidget extends StatefulWidget {
  State<TodayMenuWidget> createState() => _TodayMenuWidgetState();
}

class _TodayMenuWidgetState extends State<TodayMenuWidget> {
  bool isButtonEnabled(TodayMenuState state) {
    return !state.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodayMenuBloc, TodayMenuState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'Error while loading today\'s menu',
                Icon(Icons.error),
              ),
            );
        }
      },
      child: BlocBuilder<TodayMenuBloc, TodayMenuState>(
        builder: (context, state) {
          return state.isLoading
              ? buildLoadingWidget()
              : SingleChildScrollView(
                  child: Container(
                  padding: Dimensions.padding_16,
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    _buildTodayMenu(state),
                  ]),
                ));
        },
      ),
    );
  }

  _buildTodayMenu(TodayMenuState state) {
    return Column(
        children: state.menus?.meals?.map((e) => Text(e.title))?.toList());
  }
}
