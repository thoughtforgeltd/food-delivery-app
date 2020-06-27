import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:fooddeliveryapp/meals/model/meal_selection.dart';
import 'package:fooddeliveryapp/meals/model/meal_type_configurations.dart';
import 'package:fooddeliveryapp/meals/timeline/meal_timeline_card.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:fooddeliveryapp/utilities/global_key_utilities.dart';

class MealTimelineWidget extends StatefulWidget {
  State<MealTimelineWidget> createState() => _MealTimelineWidgetState();
}

class _MealTimelineWidgetState extends State<MealTimelineWidget> {
  ScrollController _scrollController;
  MealScheduleBloc _mealScheduleBloc;
  GlobalKey _currentDateKey = GlobalKey();

  bool isButtonEnabled(MealScheduleState state) {
    return !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _mealScheduleBloc = BlocProvider.of<MealScheduleBloc>(context);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
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
          if(state.isSuccess) WidgetsBinding.instance
              .addPostFrameCallback((_) => _scrollToCurrentDay());
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

  void _scrollToCurrentDay() {
    final position = _currentDateKey.globalPaintBounds?.bottom ?? 0;
    if(_scrollController.hasClients) _scrollController.animateTo(position, duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onMealSchedulePressed(MealSelection mealSelection) {
    _scrollToCurrentDay();
    _mealScheduleBloc.add(
      AddMealSchedule(selection: mealSelection),
    );
  }

  _buildMealsTimeline(MealScheduleState state) {
    final meals = state.mealsSelection?.meals;
    var currentDayIndex = state.mealsSelection?.meals?.indexWhere(
        (element) => element.date.isSameDayFromTimestamp(state.startDate)) ?? 0;
    if (currentDayIndex < 0) {
      currentDayIndex = 0;
    }
    return new ListView.builder(
      itemCount: meals?.length ?? 0,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return TimelineTile(
            key: currentDayIndex == index ? _currentDateKey : UniqueKey(),
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
