import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/button.dart';
import 'package:fooddeliveryapp/common/widget/loading.dart';
import 'package:fooddeliveryapp/common/widget/snack_bar.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/design/text_styles.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_bloc.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_event.dart';
import 'package:fooddeliveryapp/meals/bloc/meal_schedule_state.dart';
import 'package:fooddeliveryapp/meals/model/meal.dart';
import 'package:fooddeliveryapp/meals/model/meal_schedules.dart';
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_card.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:table_calendar/table_calendar.dart';
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
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'Error while loading timeline',
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
                  child: Container(
                  padding: Dimensions.padding_16,
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    _buildMealsTimeline(state),
                  ]),
                ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onMealSchedulePressed(MealSelection mealSelection) {
    _mealScheduleBloc.add(
      AddMealSchedule(selection: mealSelection),
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

  Center _buildDateWidget(List<Meal> meals, int index) {
    return Center(
      child: Text(
        meals[index].date.toUIDate(),
        style: TextStyles.bold,
        textAlign: TextAlign.center,
      ),
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
                    onMealSchedulePressed: _onMealSchedulePressed,
                  ))
              ?.toList()),
    );
  }
}
