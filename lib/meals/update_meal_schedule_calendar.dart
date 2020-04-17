import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/button.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/meal_selection_card.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
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
            Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: _buildEventList(state).build(context)),
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
    _mealScheduleBloc.add(DateChanged(selectedDate: day));
  }

  void _onMealSubmitted(MealSchedules meals) {
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: _calendarController.selectedDay, mealsSelection: meals),
    );
  }

  void _onAddPressed(MealSelection mealSelection) {
    print("mealSelection : _onAddPressed");
    print(mealSelection);
  }

  void _onSubtractPressed(MealSelection mealSelection) {
    print("mealSelection : _onSubtractPressed");
    print(mealSelection);
  }

  _buildEventList(MealScheduleState state) {
    final events = state.mealTypes.types;
    final meals = state.mealsSelection?.meals?.firstWhere(
        (element) =>
            element?.date == state.selectedDate?.millisecondsSinceEpoch,
        orElse: () => null);
    return new ListView.builder(
      itemCount: events.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return MealSelectionCard(
          meal: MealSelection(
              date: state.selectedDate,
              schedules: meals?.schedules?.firstWhere(
                  (element) => element.id == events[index]?.title,
                  orElse: () => null),
              configurations: events[index]),
          onAddPressed: _onAddPressed,
          onSubtractPressed: _onSubtractPressed,
        );
      },
    );
  }

  TableCalendar _buildTableCalendar(MealScheduleState state) {
    return TableCalendar(
      startDay: state.startDate,
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      formatAnimation: FormatAnimation.scale,
      weekendDays: [],
      headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_left),
          rightChevronIcon: Icon(Icons.arrow_right),
          formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        selectedColor: AppColors.colorPrimaryDark,
        todayColor: AppColors.colorPrimaryLight
      ),
      onDaySelected: _onDaySelected,
    );
  }
}
