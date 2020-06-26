import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/button.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_state.dart';
import 'package:fooddeliveryapp/meals/meal_selection_card.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MealTimelineWidget extends StatefulWidget {
  State<MealTimelineWidget> createState() => _MealTimelineWidgetState();
}

class _MealTimelineWidgetState extends State<MealTimelineWidget> {
  CalendarController _calendarController;
  MealScheduleBloc _mealScheduleBloc;

  bool isButtonEnabled(MealScheduleState state) {
    return !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _mealScheduleBloc = BlocProvider.of<MealScheduleBloc>(context);
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealScheduleBloc, MealScheduleState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Updating Meal Schedule...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meal Schedule updated!'),
                  ],
                ),
              ),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                            'There is an error while updating meal schedules..')),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<MealScheduleBloc, MealScheduleState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Container(
            padding: Dimensions.padding_16,
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              _buildMealsTimeline(state),
              _buildSubmitButton(state)
            ]),
          ));
        },
      ),
    );
  }

  Padding _buildSubmitButton(MealScheduleState state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Button(
            onPressed: isButtonEnabled(state)
                ? () => _onMealSubmitted(state.mealsSelection)
                : null,
            label: "Add Meals",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    _mealScheduleBloc.add(DateChanged(selectedDate: Timestamp.fromDate(day)));
  }

  void _onMealSubmitted(MealSchedules meals) {
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: _calendarController.selectedDay, mealsSelection: meals),
    );
  }

  void _onAddPressed(MealSelection mealSelection) {
    _mealScheduleBloc.add(
      AddMealSchedule(selection: mealSelection),
    );
  }

  void _onSubtractPressed(MealSelection mealSelection) {
    _mealScheduleBloc.add(
      RemoveMealSchedule(selection: mealSelection),
    );
  }

  _buildMealsTimeline(MealScheduleState state) {
    final meals = state.mealsSelection?.meals;
    return new ListView.builder(
      itemCount: meals?.length ?? 0,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return TimelineTile(
            indicatorStyle: IndicatorStyle(
              width: Sizes.icon_size,
              color: AppColors.colorPrimary,
              iconStyle: IconStyle(
                color: Colors.white,
                iconData: Icons.timer,
              ),
            ),
            topLineStyle: LineStyle(
              color: AppColors.colorPrimary,
            ),
            alignment: TimelineAlign.manual,
            lineX: 0.15,
            leftChild: _buildDateWidget(meals, index),
            rightChild: Column(
              children: <Widget>[
                _buildMeals(meals[index], state.mealTypes),
                SizedBox(height: 20),
              ],
            ));
      },
    );
  }

  Text _buildDateWidget(List<Meal> meals, int index) {
    return Text(
      meals[index].date.toUIDate(),
      style:
          TextStyle(color: AppColors.colorPrimary, fontWeight: FontWeight.bold),
    );
  }

  _buildMeals(Meal meal, MealTypeConfigurations type) {
    return Container(
      margin: Dimensions.padding_left_16,
      child: Column(
          children: meal.schedules
              ?.map((e) => MealTimelineCard(
                    meal: MealSelection(
                        date: meal.date,
                        schedules: e,
                        configurations: type.types
                            .firstWhere((element) => element.id == e.id)),
                    onAddPressed: _onAddPressed,
                    onSubtractPressed: _onSubtractPressed,
                  ))
              ?.toList()),
    );
  }
}
