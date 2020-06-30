import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/authentication/repository/user_repository.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_widget.dart';
import 'package:fooddeliveryapp/meals/timeline/modal/meal_timeline_modal.dart';
import 'package:fooddeliveryapp/repositories/configuration_repository.dart';
import 'package:fooddeliveryapp/repositories/meal_schedule_repository.dart';

class MealTimelineModalProvider extends StatelessWidget {
  final MealSelection _mealSelection;

  MealTimelineModalProvider({Key key, @required MealSelection mealSelection})
      : assert(mealSelection != null),
        _mealSelection = mealSelection,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealScheduleBloc>(
      create: (context) => MealScheduleBloc(
          userRepository: context.repository<UserRepository>(),
          mealScheduleRepository: context.repository<MealScheduleRepository>(),
          configurationsRepository:
              context.repository<ConfigurationsRepository>())
        ..add(MealSchedulesLoaded()),
      child: MealTimelineModal(mealSelection: _mealSelection),
    );
  }
}
