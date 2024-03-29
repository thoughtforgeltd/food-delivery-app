import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/common/widget/widget.dart';
import 'package:fooddeliveryapp/design/dimensions.dart';
import 'package:fooddeliveryapp/dish/list/widget/widget.dart';
import 'package:fooddeliveryapp/dish/model/dish.dart';
import 'package:fooddeliveryapp/mealcategory/add/add_category_alias.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/menu/add/widget/add_card.dart';
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
                    _buildDishes(state),
                    _buildAddDishCard(state),
                    _buildSubmitButton(state),
                  ]),
                );
        },
      ),
    );
  }

  Widget _buildCategoriesBar(ScheduleMenuState state) {
    final categories = state.categories?.categories ?? [];
    return Container(
        padding: Dimensions.padding_16,
        height: 80,
        child: new ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            final isSelected = category?.id == state.selectedCategory;
            return _buildCategoryChip(category, context, isSelected);
          },
        ));
  }

  Container _buildCategoryChip(
      Category category, BuildContext context, bool isSelected) {
    return Container(
        margin: Dimensions.padding_4,
        child: ChoiceChip(
          padding: Dimensions.padding_8,
          elevation: 4,
          label: Text(category?.title),
          avatar: category.image != null
              ? SvgPicture.network(category.image,
                  height: 25,
                  width: 25,
                  fit: BoxFit.cover,
                  color: isSelected == true
                      ? Theme.of(context).chipTheme.secondaryLabelStyle.color
                      : Theme.of(context).chipTheme.labelStyle.color)
              : Icon(Icons.error),
          selected: isSelected,
          onSelected: (selected) => _onCategorySelected(selected, category),
        ));
  }

  _onCategorySelected(bool isSelected, Category category) {
    _mealScheduleBloc.add(CategoryChanged(category: category));
  }

  Widget _buildSubmitButton(ScheduleMenuState state) {
    return Container(
      padding: Dimensions.padding_16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Button(
            onPressed: isButtonEnabled(state)
                ? () => _onMealSubmitted(state.menus)
                : null,
            label: "Schedule Menu",
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
    _mealScheduleBloc.add(
      Submitted(
          selectedDate: _calendarController.selectedDay,
          menus: menus,
          handleSubmitted: true),
    );
  }

  void _onDishAdded(Dish dish) {
    _mealScheduleBloc.add(
      AddDishSchedule(dish: dish),
    );
  }

  Widget _buildDishes(ScheduleMenuState state) {
    final MenuItemView events = state.menuSelection?.items?.firstWhere(
        (element) => element?.category?.id == state.selectedCategory,
        orElse: () => null);
    final dishes = events?.dishes ?? [];
    return _buildDishCards(dishes);
  }

  Widget _buildAddDishCard(ScheduleMenuState state) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: Dimensions.padding_lr_16,
        child: AddCard(
            title: "Add Dish",
            onAddButtonPressed: (message) => _onAddDishPressed(state)));
  }

  void _showDialog(ScheduleMenuState state) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SelectDishDialog(onDishSelected: (dish) => _onDishAdded(dish));
      },
    );
  }

  Widget _buildDishCards(List<Dish> dishes) {
    return Container(
        padding: Dimensions.padding_16,
        child: new ListView.builder(
          itemCount: dishes.length,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return DishCard(
              dish: dishes[index],
              onDeletePressed: _onDeleteDishPressed,
              onEditPressed: null,
            );
          },
        ).build(context));
  }

  _onAddDishPressed(ScheduleMenuState state) {
    _showDialog(state);
  }

  _onDeleteDishPressed(Dish dish) {
    _mealScheduleBloc.add(
      RemoveDishEvent(dish: dish),
    );
  }

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
          selectedColor: Theme
              .of(context)
              .colorScheme
              .primary,
          todayColor: Theme
              .of(context)
              .colorScheme
              .primaryVariant),
      onDaySelected: _onDaySelected,
    );
  }
}
