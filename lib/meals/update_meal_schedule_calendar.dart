import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/button.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_type.dart';
import 'package:table_calendar/table_calendar.dart';

import 'bloc/meal_schedule_state.dart';

class UpdateMealScheduleCalendar extends StatefulWidget {
  State<UpdateMealScheduleCalendar> createState() =>
      _UpdateMealScheduleCalendarState();
}

class _UpdateMealScheduleCalendarState
    extends State<UpdateMealScheduleCalendar> {
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
                    Text('There is an error while updating meal schedules..'),
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
          return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            _buildTableCalendar(state),
            const SizedBox(height: 8.0),
            _buildEventList(state.mealTypes.types).build(context),
            _buildSubmitButton(state)
          ]);
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
            label: "Submit",
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
    _mealScheduleBloc.add(DateChanged(selectedDate: day));
  }

  void _onMealSubmitted(MealSchedules meals) {
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: _calendarController.selectedDay, mealsSelection: meals),
    );
  }

  _buildEventList(List<MealType> events) {
    return new ListView.builder(
      itemCount: events.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String key = events[index].id;
        String value = events[index].title;
        return new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("$key"),
              subtitle: new Text("$value"),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  TableCalendar _buildTableCalendar(MealScheduleState state) {
    return TableCalendar(
      startDay: state.startDate,
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      formatAnimation: FormatAnimation.scale,
      headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_left),
          rightChevronIcon: Icon(Icons.arrow_right),
          formatButtonVisible: false),
      onDaySelected: _onDaySelected,
    );
  }
}
