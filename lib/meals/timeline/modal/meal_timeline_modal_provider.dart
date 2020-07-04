import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';
import 'package:fooddeliveryapp/meals/timeline/modal/modal.dart';

class MealTimelineModalProvider extends StatelessWidget {
  final MealSelection _mealSelection;
  final void Function() _onMealScheduleUpdated;

  MealTimelineModalProvider(
      {Key key,
      @required MealSelection mealSelection,
      @required Function() onMealScheduleUpdated})
      : assert(mealSelection != null),
        _mealSelection = mealSelection,
        _onMealScheduleUpdated = onMealScheduleUpdated,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MealScheduleBloc>(
      create: (context) =>
      BlocProvider.of(context)
        ..add(MealSchedulesLoaded()),
      child: MealTimelineModal(
          mealSelection: _mealSelection,
          onMealScheduleUpdated: _onMealScheduleUpdated),
    );
  }
}
