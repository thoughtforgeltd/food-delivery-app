import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/button.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';
import 'package:fooddeliveryapp/meals/schedule/widget.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/meal_schedule_state.dart';

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
        if (state.isSuccess && state.isSubmitted) {
          (ModalRoute.of(context).settings.arguments as UpdateMealArguments)
              ?.onEditPressed("");
          Navigator.pop(context);
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'There is an error while updating meal schedules..',
                Icon(Icons.error),
              ),
            );
        }
      },
      child: BlocBuilder<MealScheduleBloc, MealScheduleState>(
        builder: (context, state) {
          return state.isSubmitting
              ? buildLoadingWidget()
              : SingleChildScrollView(
            child:
            Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              _buildTableCalendar(state),
              Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: _buildEventList(state).build(context)),
              _buildSubmitButton(state)
            ]),
          );
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
          selectedDate: _calendarController.selectedDay,
          mealsSelection: meals,
          handleSubmitted: true),
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

  _buildEventList(MealScheduleState state) {
    final events = state.categories.categories;
    final meals = state.mealsSelection?.meals?.firstWhere(
        (element) => element?.date?.isSameDayFromTimestamp(state.selectedDate),
        orElse: () => null);
    return new ListView.builder(
      itemCount: events.length,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return MealSelectionCard(
          meal: MealSelection(
              date: state.selectedDate,
              schedules: meals?.schedules?.firstWhere(
                      (element) => element?.id == events[index]?.id,
                  orElse: () => null),
              category: events[index]),
          onAddPressed: _onAddPressed,
          onSubtractPressed: _onSubtractPressed,
        );
      },
    );
  }

  TableCalendar _buildTableCalendar(MealScheduleState state) {
    return TableCalendar(
      startDay: state.startDate.toDate(),
      calendarController: _calendarController,
      initialCalendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      formatAnimation: FormatAnimation.scale,
      weekendDays: [],
      headerStyle: HeaderStyle(
          leftChevronIcon: Icon(Icons.arrow_left),
          rightChevronIcon: Icon(Icons.arrow_right),
          formatButtonVisible: false),
      calendarStyle: CalendarStyle(
          selectedColor: Theme.of(context).colorScheme.primary,
          todayColor: Theme.of(context).colorScheme.primaryVariant),
      onDaySelected: _onDaySelected,
    );
  }
}
