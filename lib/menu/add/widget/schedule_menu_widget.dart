import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/colors.dart';
import 'package:fooddeliveryapp/dish/model/dish.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleMenuWidget extends StatefulWidget {
  State<ScheduleMenuWidget> createState() => _ScheduleMenuWidgetState();
}

class _ScheduleMenuWidgetState extends State<ScheduleMenuWidget> {
  CalendarController _calendarController;
  ScheduleMenuBloc _mealScheduleBloc;

  bool isButtonEnabled(ScheduleMenuState state) {
    return !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _mealScheduleBloc = BlocProvider.of<ScheduleMenuBloc>(context);
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleMenuBloc, ScheduleMenuState>(
      listener: (context, state) {
        if (state.isSuccess && state.isSubmitted) {
//          (ModalRoute.of(context).settings.arguments as UpdateMealArguments)
//              ?.onEditPressed("");
//          Navigator.pop(context);
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              getAppSnackBar(
                'There is an error while updating menu schedules..',
                Icon(Icons.error),
              ),
            );
        }
      },
      child: BlocBuilder<ScheduleMenuBloc, ScheduleMenuState>(
        builder: (context, state) {
          return state.isSubmitting
              ? buildLoadingWidget()
              : SingleChildScrollView(
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    _buildTableCalendar(state),
                    _buildCategoriesBar(state),
//                    Container(
//                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
//                        child: _buildEventList(state).build(context)),
                    _buildSubmitButton(state)
                  ]),
                );
        },
      ),
    );
  }

  Widget _buildCategoriesBar(ScheduleMenuState state) {
    final categories = state.categories?.categories ?? [];
    return Container(
        height: 60,
        child: new ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return CategoryCard(
              category: categories[index],
              onSelected: _onCategorySelected,
            );
          },
        ));
  }

  _onCategorySelected(Category category) {}

  Padding _buildSubmitButton(ScheduleMenuState state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Button(
            onPressed: isButtonEnabled(state)
                ? () => _onMealSubmitted(state.menus)
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

  void _onMealSubmitted(MenusView menus) {
    final temp = MenusView(menus: [
      MenuView(date: DateTime.now(), items: [
        MenuItemView(
            category: Category(
                image: "image",
                id: "breakfast",
                description: "Description",
                title: "title"),
            dishes: [
              Dish(
                  title: "Title",
                  description: "Description",
                  id: "dish1",
                  image: "image",
                  note: "note")
            ])
      ])
    ]);
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: _calendarController.selectedDay,
          menus: temp,
          handleSubmitted: true),
    );
  }

  void _onAddPressed(MenuView menus) {
    _mealScheduleBloc.add(
      AddMenuSchedule(menus: menus),
    );
  }

  void _onSubtractPressed(MenuView menus) {
    _mealScheduleBloc.add(
      RemoveMenuSchedule(menus: menus),
    );
  }

//  _buildEventList(ScheduleMenuState state) {
//    final events = state.menus.items[state.selectedDate];
//    final meals = state.menus?.menus?.firstWhere(
//        (element) => element?.date?.isSameDayFromTimestamp(state.selectedDate),
//        orElse: () => null);
//    return new ListView.builder(
//      itemCount: events.length,
//      scrollDirection: Axis.vertical,
//      physics: NeverScrollableScrollPhysics(),
//      shrinkWrap: true,
//      itemBuilder: (BuildContext context, int index) {
//        return MealSelectionCard(
//          meal: MealSelection(
//              date: state.selectedDate,
//              schedules: meals?.schedules?.firstWhere(
//                  (element) => element?.id == events[index]?.id,
//                  orElse: () => null),
//              category: events[index]),
//          onAddPressed: _onAddPressed,
//          onSubtractPressed: _onSubtractPressed,
//        );
//      },
//    );
//  }

  TableCalendar _buildTableCalendar(ScheduleMenuState state) {
    return TableCalendar(
      startDay: state.startDate,
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
          selectedColor: AppColors.colorPrimaryDark,
          todayColor: AppColors.colorPrimaryLight),
      onDaySelected: _onDaySelected,
    );
  }
}
