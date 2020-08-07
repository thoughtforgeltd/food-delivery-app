import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddeliveryapp/mealcategory/meal_category.dart';
import 'package:fooddeliveryapp/menu/add/add_schedule.dart';
import 'package:fooddeliveryapp/repositories/repositories.dart';
import 'package:fooddeliveryapp/utilities/date_utilities.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ScheduleMenuBloc extends Bloc<ScheduleMenuEvent, ScheduleMenuState> {
  final MenuRepository _menuRepository;
  final MealCategoryRepository _categoryRepository;
  final DishRepository _dishRepository;

  ScheduleMenuBloc(
      {@required MenuRepository todayMenuRepository,
      @required MealCategoryRepository categoryRepository,
      @required DishRepository dishRepository})
      : assert(todayMenuRepository != null),
        _menuRepository = todayMenuRepository,
        _categoryRepository = categoryRepository,
        _dishRepository = dishRepository;

  @override
  ScheduleMenuState get initialState => ScheduleMenuState.empty();

  @override
  Stream<Transition<ScheduleMenuEvent, ScheduleMenuState>> transformEvents(
    Stream<ScheduleMenuEvent> events,
    TransitionFunction<ScheduleMenuEvent, ScheduleMenuState> transitionFn,
  ) {
    final debounceStream = events.where((event) {
      return (event is MenuSchedulesLoaded ||
          event is Submitted ||
          event is CategoryChanged ||
          event is AddDishSchedule ||
          event is DateChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      debounceStream,
      transitionFn,
    );
  }

  @override
  Stream<ScheduleMenuState> mapEventToState(
    ScheduleMenuEvent event,
  ) async* {
    if (event is MenuSchedulesLoaded) {
      yield* _mapMenuSchedulesLoadedEventToState();
    } else if (event is Submitted) {
      yield* _mapMenuSchedulesSubmittedEventToState(event);
    } else if (event is CategoryChanged) {
      yield* _mapCategoryChangedEventToState(event);
    } else if (event is AddDishSchedule) {
      yield* _mapAddDishScheduleEventToState(event);
    } else if (event is DateChanged) {
      yield* _mapDateChangedEventToState(event);
    }
  }

  Stream<ScheduleMenuState> _mapMenuSchedulesLoadedEventToState() async* {
    yield state.loading();
    try {
      final menus = await _menuRepository.loadMenus();
      final categories = await _categoryRepository.loadCategories();
      final dishes = await _dishRepository.loadDishes();
      final selectedCategory = categories?.categories?.first?.id;
      yield state.success(
          menus: menus.toMenusView(categories, dishes),
          categories: categories,
          selectedCategory: selectedCategory);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<ScheduleMenuState> _mapCategoryChangedEventToState(
      CategoryChanged event) async* {
    yield state.success(selectedCategory: event.category.id);
  }

  Stream<ScheduleMenuState> _mapAddDishScheduleEventToState(
      AddDishSchedule event) async* {
    final selectedCategory = state.categories?.categories?.firstWhere(
            (element) => element.id == state.selectedCategory,
        orElse: null);
    final dishNeedsToBeAdded = event.dish;
    var result = MenusView();
    result.menus = [];
    if (state?.menus?.menus != null) result.menus.addAll(state.menus.menus);
    final menuView = result.menus?.firstWhere(
            (element) => element?.date?.isSameDay(state.selectedDate),
        orElse: () => null);
    final menuViewItems = menuView?.items;
    final dishes = menuViewItems?.firstWhere(
            (element) => element?.category?.id == state.selectedCategory,
        orElse: () => null);

    final dish = dishes?.dishes?.firstWhere(
            (element) => element?.id == dishNeedsToBeAdded?.id,
        orElse: () => null);

    if (menuView == null) {
      result.menus.add(MenuView(date: state.selectedDate, items: [
        MenuItemView(category: selectedCategory, dishes: [dishNeedsToBeAdded])
      ]));
    } else if (menuViewItems == null) {
      menuView.date = state.selectedDate;
      menuView.items = [
        MenuItemView(category: selectedCategory, dishes: [dishNeedsToBeAdded])
      ];
    } else if (dishes == null) {
      menuViewItems.add(MenuItemView(
          category: selectedCategory, dishes: [dishNeedsToBeAdded]));
    } else if (dishes.dishes == null) {
      dishes.dishes = [dishNeedsToBeAdded];
    } else if (dish == null) {
      dishes.dishes.add(dishNeedsToBeAdded);
    } else {
      // Dish already exist, Do nothing!x
    }

    yield state.copyWith(menus: result);
  }

  Stream<ScheduleMenuState> _mapMenuSchedulesSubmittedEventToState(
      Submitted event) async* {
    yield state.loading();
    try {
      await _menuRepository.addMenus(event.menus.toMenus());
      yield state.success(menus: event.menus);
    } catch (_) {
      yield state.failure();
    }
  }

  Stream<ScheduleMenuState> _mapDateChangedEventToState(
      DateChanged event) async* {
    yield state.copyWith(
        selectedCategory: state.categories.categories.first.id,
        selectedDate: event.selectedDate);
  }
}
