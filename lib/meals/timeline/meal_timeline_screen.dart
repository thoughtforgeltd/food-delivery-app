import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_widget.dart';
import 'package:fooddeliveryapp/repositories/configuration_repository.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';

class MealTimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealScheduleBloc>(
      create: (context) => MealScheduleBloc(
          userRepository: context.repository<UserRepository>(),
          mealScheduleRepository: context.repository<MealScheduleRepository>(),
          configurationsRepository:
              context.repository<ConfigurationsRepository>())
        ..add(MealSchedulesLoaded()),
      child: MealTimelineWidget(),
    );
  }
}
