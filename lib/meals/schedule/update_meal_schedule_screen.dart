import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/schedule/widget.dart';

class UpdateMealScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Meal Schedule')),
      body: BlocProvider<MealScheduleBloc>(
        create: (context) =>
            BlocProvider.of(context)..add(MealSchedulesLoaded()),
        child: UpdateMealScheduleCalendar(),
      ),
    );
  }
}
