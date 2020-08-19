import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/text/subtitle1.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/menu/today/bloc/bloc.dart';
import 'package:fooddeliveryapp/menu/today/widget/widget.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';

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
              : state.isSuccess
                  ? state?.menus != null
                      ? SingleChildScrollView(
                          child: Container(
                          padding: Dimensions.padding_16,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                buildDate(state),
                                buildTodayMenu(state),
                              ]),
                        ))
                      : Center(
                          child: Subtitle1(
                              text: "There is no menu available for today"),
                        )
                  : Container();
        },
      ),
    );
  }

  buildDate(TodayMenuState state) {
    return Container(child: Text(state?.menus?.date?.toUIDate() ?? ""));
  }

  buildTodayMenu(TodayMenuState state) {
    return Column(
        children: state?.menus?.items
            ?.map((menu) => TodayMenuCard(menu: menu))
            ?.toList() ??
            []);
  }
}
