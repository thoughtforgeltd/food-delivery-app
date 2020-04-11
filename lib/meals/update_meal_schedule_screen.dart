import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/update_meal_schedule_calendar.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';

class UpdateMealScheduleScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final MealScheduleRepository _mealScheduleRepository;

  UpdateMealScheduleScreen(
      {Key key,
      @required UserRepository userRepository,
      @required MealScheduleRepository mealScheduleRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        _mealScheduleRepository = mealScheduleRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Meal Schedule')),
      body: BlocProvider<MealScheduleBloc>(
        create: (context) => MealScheduleBloc(
            userRepository: _userRepository,
            mealScheduleRepository: _mealScheduleRepository),
        child: UpdateMealScheduleCalendar(),
      ),
    );
  }
}
