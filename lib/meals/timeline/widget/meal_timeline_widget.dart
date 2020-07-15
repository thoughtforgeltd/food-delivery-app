import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/design/sizes.dart';
import 'package:fooddeliveryapp/design/text_styles.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/meals/bloc/bloc.dart';
import 'package:fooddeliveryapp/meals/model/model.dart';
import 'package:fooddeliveryapp/meals/timeline/modal/modal.dart';
import 'package:fooddeliveryapp/meals/timeline/widget/widget.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:fooddeliveryapp/utilities/global_key_utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
          if (state.isSuccess)
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _scrollToCurrentDay());
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed('/update_meals',
                      arguments:
                          UpdateMealArguments(onEditPressed: _onEditPressed));
                },
              ),
              body: state.isSubmitting
                  ? buildLoadingWidget()
                  : SingleChildScrollView(
                      child: Container(
                      padding: Dimensions.padding_16,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _buildMealsTimeline(state),
                          ]),
                    )));
        },
      ),
    );
  }

  void _scrollToCurrentDay() {
    final position = _currentDateKey.globalPaintBounds?.bottom ?? 0;
    if (_scrollController.hasClients)
      _scrollController.animateTo(position,
          duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onMealSchedulePressed(
      MealScheduleState state, MealSelection mealSelection) {
    showMaterialModalBottomSheet(
        context: context,
        backgroundColor: AppColors.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.topRadius,
        ),
        builder: (context, scrollController) => MealTimelineModalProvider(
            mealSelection: mealSelection,
            onMealScheduleUpdated: _onMealsUpdated));
  }

  void _onMealsUpdated() {
    _mealScheduleBloc.add(MealSchedulesLoaded());
  }

  _buildMealsTimeline(MealScheduleState state) {
    final meals = state.mealsSelection?.meals;
    var currentDayIndex = state.mealsSelection?.meals?.indexWhere((element) =>
            element.date.isSameDayFromTimestamp(state.startDate)) ??
        0;
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
        var isCurrentDay = currentDayIndex == index;
        var isPastDay = index < currentDayIndex;
        return TimelineTile(
            key: isCurrentDay ? _currentDateKey : UniqueKey(),
            indicatorStyle: IndicatorStyle(
              width: Sizes.icon_size,
              color: isCurrentDay
                  ? AppColors.colorPrimaryAccent
                  : isPastDay
                      ? AppColors.colorTransparent
                      : AppColors.colorPrimary,
              iconStyle: IconStyle(
                color: isCurrentDay
                    ? AppColors.colorWhite
                    : isPastDay
                        ? AppColors.colorTransparent
                        : AppColors.colorWhite,
                iconData: isCurrentDay ? Icons.today : Icons.timer,
              ),
            ),
            topLineStyle: LineStyle(
              color: isCurrentDay
                  ? AppColors.colorPrimaryAccent
                  : isPastDay ? AppColors.colorDisable : AppColors.colorPrimary,
            ),
            bottomLineStyle: LineStyle(
              color: isCurrentDay
                  ? AppColors.colorPrimaryAccent
                  : isPastDay ? AppColors.colorDisable : AppColors.colorPrimary,
            ),
            alignment: TimelineAlign.manual,
            lineX: 0.15,
            leftChild: _buildDateWidget(meals, index, isPastDay),
            rightChild: Column(
              children: <Widget>[
                _buildMeals(state, meals[index], state.categories, isPastDay),
                SizedBox(height: 20),
              ],
            ));
      },
    );
  }

  Center _buildDateWidget(List<Meal> meals, int index, bool isPastDay) {
    return Center(
      child: Text(
        meals[index].date.toUIDate(),
        style: isPastDay ? TextStyles.disabledBold : TextStyles.bold,
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildMeals(MealScheduleState state, Meal meal, Categories categories,
      bool isPastDay) {
    return Container(
      margin: Dimensions.padding_left_16,
      child: Column(
          children: meal.schedules
              ?.where(
                  (element) => element.quantity != null && element.quantity > 0)
              ?.map((e) => MealTimelineCard(
                    meal: MealSelection(
                        date: meal.date,
                    schedules: e,
                    category: categories.categories
                        .firstWhere((element) => element.id == e.id)),
                onMealSchedulePressed: (selection) =>
                    _onMealSchedulePressed(state, selection),
                disabled: isPastDay,
              ))
              ?.toList()),
    );
  }

  _onEditPressed(String message) {
    _onMealsUpdated();
  }
}
