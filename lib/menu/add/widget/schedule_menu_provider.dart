import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_schedule.dart';

class ScheduleMenuProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Menu')),
      body: BlocProvider<ScheduleMenuBloc>(
        create: (context) =>
            BlocProvider.of(context)..add(MenuSchedulesLoaded()),
        child: ScheduleMenuWidget(),
      ),
    );
  }
}
