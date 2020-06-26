import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_bloc.dart';
import 'package:fooddeliveryapp/authentication/bloc/authentication_event.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_event.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_state.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigtion_bloc.dart';
import 'package:fooddeliveryapp/home/bloc/model/bottom_navigation_options.dart';

class BottomNavigationWidget extends StatefulWidget {
  State<BottomNavigationWidget> createState() => _UpdateBottomNavigationState();
}

class _UpdateBottomNavigationState extends State<BottomNavigationWidget> {
  BottomNavigationBloc _bottomNavigationBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            )
          ],
        ),
        body: Text(state.options.title),
        bottomNavigationBar: _buildEventList(state),
      );
    });
  }

  _buildEventList(BottomNavigationState state) {
    return BottomNavigationBar(
      currentIndex: state.options.index,
      selectedItemColor: AppColors.colorPrimaryAccent,
      showUnselectedLabels: false,
      onTap:(int index) {
        _bottomNavigationBloc.add(BottomNavigationChanged(
          options: BottomNavigationOptions.values.firstWhere(
                  (element) => element.index == index,
              orElse: () => BottomNavigationState.DEFAULT_SELECTION
          )
        ));
      },
      items: BottomNavigationOptions.values.map((BottomNavigationOptions options){
        return BottomNavigationBarItem(
          icon: new Icon(options.icon),
          title: new Text(options.title));
      }).toList(),
    );
  }
}
