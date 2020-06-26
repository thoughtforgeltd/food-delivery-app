import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigation_state.dart';
import 'package:fooddeliveryapp/home/bloc/bottom_navigtion_bloc.dart';

class BottomNavigationWidget extends StatefulWidget {
  State<BottomNavigationWidget> createState() => _UpdateBottomNavigationState();
}

class _UpdateBottomNavigationState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: _buildEventList(state)),
      ]);
    });
  }

  _buildEventList(BottomNavigationState state) {
    return BottomNavigationBar(
      currentIndex: 0, // this will be set when a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Messages'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}
