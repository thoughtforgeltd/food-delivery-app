import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/console/console.dart';

class ConsoleProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConsoleBloc>(
      create: (context) =>
          BlocProvider.of(context)..add(LoadConsoleActionsEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Console")),
        body: ConsoleWidget(),
      ),
    );
  }
}
