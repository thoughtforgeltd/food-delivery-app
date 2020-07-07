import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/console/console.dart';

class ConsoleWidget extends StatefulWidget {
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsoleBloc, ConsoleState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[_buildActionsList(state)],
          ),
        );
      },
    );
  }

  _buildActionsList(ConsoleState state) {
    return Column(
        children: state.actions
            ?.map((action) =>
                ConsoleActionCard(action: action, onPressed: onActionPressed))
            ?.toList());
  }

  onActionPressed(ConsoleActions action) {}
}
